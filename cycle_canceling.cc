#include <iostream>
#include <fstream>
#include <limits>
#include <chrono>

#include <lemon/smart_graph.h>
#include <lemon/lgf_reader.h>
#include <lemon/cycle_canceling.h>
#include <lemon/capacity_scaling.h>
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
	/* Measuring the runtime in milliseconds */
	auto begin = std::chrono::high_resolution_clock::now();
	cs.lowerMap(lower).upperMap(capacity).costMap(cost).supplyMap(supply).run();
	auto end = std::chrono::high_resolution_clock::now();
	long long total_time = std::chrono::duration_cast<std::chrono::milliseconds>(end-begin).count();
	/* Print total flow cost */
	printf("Total flow cost: %d\n\n", cs.totalCost<int>());
	printf("The runtime of Cycle Canceling algorithm id %lld ms.\n", total_time);
	printf("Summary:\n(%d,%d,%d,%lld)\n", countNodes(g), countArcs(g), cs.totalCost<int>(), total_time);

	/* Uncomment the following code to display the whole graph */
	/* Printing the network to standard output */
	// cs.flowMap(flow);
	// digraphWriter(g).                  // write g to the standard output
	// 	attribute("problem","min").
	// 	nodeMap("supply", supply).     // write the supply to output
	// 	arcMap("capacity", capacity).  // write cap into 'capacity'
	// 	arcMap("cost", cost).          // write 'cost' for for arcs
	// 	arcMap("flow", flow).          // write 'flow' for for arcs
	// 	run();

	return 0;
}