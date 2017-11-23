#include <iostream>
#include <fstream>
#include <lemon/smart_graph.h>
#include <lemon/capacity_scaling.h>
#include <lemon/dimacs.h>

using namespace lemon;
using namespace std;

int main(int argc, char** argv){
	if(argc < 2){
		cerr << "Usage:\n\t./a.out <input file>\n";
		exit(-1);
	}
	// Create a directed graph
	DIGRAPH_TYPEDEFS(SmartDigraph);
	SmartDigraph g;
	// Create data structures (i.e. maps) associating values to nodes and arcs of the graph
	IntArcMap lower(g), capacity(g), cost(g);
	IntNodeMap supply(g);
	Node s, t;

	// Read DIMACS input file
	ifstream input(argv[1]);
	try{
		readDimacsMin(input, g, lower, capacity, cost, supply);
	}catch(Exception& e){
		cerr << "Error: " << e.what() << endl;
		return -1;
	}
	input.close();

	cout << "\nA digraph is read from " << argv[1] << endl;
	cout << "Number of nodes: " << countNodes(g) << endl;
	cout << "Number of arcs: " << countArcs(g) << endl;

	CapacityScaling<SmartDigraph> cs(g);
	// // First run
	// cs.upperMap(capacity).costMap(cost).stSupply(s, t, 100).run();

	// cout << "Total cost: " << cs.totalCost<double>() << endl;
	// cout << "We can write it to the standard output:" << endl;

	// cs.flowMap(flow);

	return 0;
}