#include <iostream>
#include <fstream>
#include <limits>

#include <lemon/smart_graph.h>
#include <lemon/lgf_reader.h>
#include <lemon/network_simplex.h>
#include <lemon/cycle_canceling.h>
#include <lemon/dimacs.h>

using namespace lemon;

int main(int argc, char** argv){
	if(argc < 2){
		perror("Usage:\n\t./a.out <input file>\n");
		exit(-1);
	}
	/* Create a directed graph */
	DIGRAPH_TYPEDEFS(SmartDigraph);
	SmartDigraph g;
	/* Create data structures (i.e. maps) associating values to nodes and arcs of the graph */
	IntArcMap lower(g), capacity(g), cost(g);
	IntArcMap flow(g);
	IntNodeMap supply(g);

	/* Read DIMACS input file */
	std::ifstream input(argv[1]);
	try{
		readDimacsMin(input, g, lower, capacity, cost, supply);
	}catch(Exception& e){
		perror(e.what());
		return -1;
	}
	input.close();

	printf("\nA digraph is read from %s.\n", argv[1]);
	printf("Number of nodes: %d\n", countNodes(g));
	printf("Number of arcs: %d\n", countArcs(g));

	printf("Running Cycle Canceling...\n");
	/* Initialize CycleCanceling algorithm object */
	CycleCanceling<SmartDigraph> cs(g);
	/* Running the algorithm */
	cs.lowerMap(lower).upperMap(capacity).costMap(cost).supplyMap(supply).run();
	/* Print total flow cost */
	printf("Total flow cost: %d\n\n", cs.totalCost<int>());
	
	/* Printing the network to standard output */
	Node s, t;
	cs.flowMap(flow);
	digraphWriter(g).                  // write g to the standard output
		attribute("problem","min").
		nodeMap("supply", supply).     // write the supply to output
		arcMap("capacity", capacity).  // write cap into 'capacity'
		arcMap("cost", cost).          // write 'cost' for for arcs
		arcMap("flow", flow).          // write 'flow' for for arcs
		run();


	/* Another method to verify the solution */
	/* Initialize NetworkSimplex algorithm object */
	printf("\n\nRunning Network Simplex...\n");
	NetworkSimplex<SmartDigraph> ns(g);
	ns.lowerMap(lower).upperMap(capacity).costMap(cost).supplyMap(supply).run();

	/* Print total flow cost */
	printf("Total flow cost: %d\n\n", ns.totalCost());

	/* Print flow values on the arcs */
	// printf("Flow values on arcs:\n");
	// for (ArcIt a(g); a != INVALID; ++a) {
	// 	printf("Arc %d: %d/%d\n", g.id(a), ns.flow(a), capacity[a]);
	// }

	return 0;
}