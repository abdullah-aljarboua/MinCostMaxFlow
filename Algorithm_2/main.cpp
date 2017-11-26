#include <iostream>
#include <stdio.h>
#include <cstring>
#include <cmath>
#include <algorithm>
#include <fstream>
#include <chrono>

#define MAXN 1000003
#define MAXM 40000004
using namespace std;
const int INF = 0x3f3f3f3f;
struct EDGE{
    int to, cap, next, flow, cost;
}edge[MAXM];
int q[1000000], head[MAXN], tol;
int pre[MAXN], dis[MAXN];
bool vis[MAXN];
int n, m;
void init(){
    tol = 0;
    memset(head, -1, sizeof(head));
}
void addEdge(int u, int v, int cap, int cost){
    edge[tol].cap = cap;
    edge[tol].cost = cost;
    edge[tol].flow = 0;
    edge[tol].next = head[u];
    edge[tol].to = v;
    head[u] = tol++;
    edge[tol].cap = 0;
    edge[tol].cost = -cost;
    edge[tol].flow = 0;
    edge[tol].next = head[v];
    edge[tol].to = u;
    head[v] = tol++;
}
bool spfa(int st, int en){
    int rear = 0, front = 0;
    for (int i = st; i <= en+1; i++){
        dis[i] = INF;
        vis[i] = false;
        pre[i] = -1;
    }
    dis[st] = 0;
    vis[st] = true;
    q[front++] = st;
    while(rear < front){
        int u = q[rear++];
        vis[u] = false;
        for (int e = head[u]; e != -1; e = edge[e].next){
            int v = edge[e].to;
            if (edge[e].cap > edge[e].flow && dis[v] > dis[u]+edge[e].cost){
                dis[v] = dis[u] + edge[e].cost;
                pre[v] = e;
                if (!vis[v]){
                    vis[v] = true;
                    q[front++] = v;
                }
            }
        }
    }
    return pre[en] != -1;
}
int minCostMaxflow(int st, int en, int &cost){
    int flow = 0;
    while(spfa(st, en)){
        int Min = INF;
        for (int i = pre[en]; i != -1; i = pre[edge[i^1].to]){
            Min = Min > (edge[i].cap-edge[i].flow) ? (edge[i].cap-edge[i].flow) : Min;
        }
        for (int i = pre[en]; i != -1; i = pre[edge[i^1].to]){
            edge[i].flow += Min;
            edge[i^1].flow -= Min;
        }
        cost += dis[en] * Min;
//        printf("%d\n", cost);
    }
    return flow;
}
int main(int argc, char** argv){
	if(argc < 2){
		perror("Usage:\n\t./a.out <input file>\n");
		exit(-1);
	}
    FILE *fp;
    int i, cost, u, v, cap, source, sink, supply;
    char* filename = argv[1];
    if((fp = fopen(filename,"r")) == NULL) //判断文件是否存在及可读
    {
        printf("error!");
        return 0;
    }
    fscanf(fp, "%d %d", &n, &m);
    fscanf(fp, "%d%d%d", &source, &sink, &supply);
//    scanf("%d%d", &n, &m);
    init();
    for (i = 0; i < m; i++){
        fscanf(fp, "%d%d%d%d", &u, &v, &cap, &cost);
        addEdge(u, v, cap, cost);
//        addEdge(v, u, cap, cost);
    }
    addEdge(0, source, supply, 0);
    addEdge(sink, sink+1, supply, 0);
    cost = 0;

    auto begin = std::chrono::high_resolution_clock::now();
    minCostMaxflow(0, sink+1, cost);
    auto end = std::chrono::high_resolution_clock::now();
    long long total_time = std::chrono::duration_cast<std::chrono::milliseconds>(end-begin).count();

    printf( "Time: %lld milliseconds\n", total_time);
    printf("Cost: %d\n", cost);
    printf("(%d,%d,%d,%lld)\n", n, m, cost, total_time);
    return 0;
}