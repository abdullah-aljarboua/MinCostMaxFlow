#include <lemon/arg_parser.h>
#include <fstream>
#include "main.h"

int main(int argc, char **argv)
{
	if(argc < 2){
		perror("Usage:\n\t./a.out <parameters file>\n");
		exit(-1);
	}
	std::ifstream input(argv[1]);
	if(input.fail()){
		perror("Couldn't open the parameters file. Abort...\n");
		exit(-1);
	}
	int seed=1;
	int problem=0;
	int parms[PROBLEM_PARMS];

	/* getting the parameters from the file */
	input >> seed;
	input >> problem;
	input >> NODES;
	input >> SOURCES;
	input >> SINKS;
	input >> DENSITY;
	input >> MINCOST;
	input >> MAXCOST;
	input >> SUPPLY;
	input >> TSOURCES;
	input >> TSINKS;
	input >> HICOST;
	input >> CAPACITATED;
	input >> MINCAP;
	input >> MAXCAP;
	input.close();

	lemon::ArgParser ap(argc,argv);
	ap.refOption("seed","Random seed (default: 1)",seed)
		.refOption("problem","Problem type (default: 0)",problem)
		.refOption("nodes","Number of nodes (default: 10)",NODES)
		.refOption("sources","Source nodes (default: 3)",SOURCES)
		.refOption("sinks","Sink nodes (default: 3)",SINKS)
		.refOption("density","Number of arcs (default: 30)",DENSITY)
		.refOption("mincost","Minimum arc cost (default: 10)",MINCOST)
		.refOption("maxcost","Maximum arc cost (default: 99)",MAXCOST)
		.refOption("supply","Total supply (default: 1000)",SUPPLY)
		.refOption("tsources","Transshipment sources (default: 0)",TSOURCES)
		.refOption("tsinks","Transshipment sinks (default: 0)",TSINKS)
		.refOption("hicost",
			"Percent of skeleton arcs given maximum cost (default: 0)",
			HICOST)
		.refOption("capacitated","Percent of arcs to be capacitated (default: 100)",
			CAPACITATED)
		.refOption("mincap","Minimum arc capacity (default: 100)",MINCAP)
		.refOption("maxcap","Maximum arc capacity (default: 1000)",MAXCAP);

	// NODES=10;
	// SOURCES=3;
	// SINKS=3;
	// DENSITY=30;
	// MINCOST=10;
	// MAXCOST=99;
	// SUPPLY=1000;
	// TSOURCES=0;
	// TSINKS=0;
	// HICOST=0;
	// CAPACITATED=100;
	// MINCAP=100;
	// MAXCAP=1000;

	ap.run();

	long lparms[PROBLEM_PARMS];
	for(int i=0;i<PROBLEM_PARMS;i++)
		lparms[i]=parms[i];

	return orig_main(seed,problem,lparms);  
}

