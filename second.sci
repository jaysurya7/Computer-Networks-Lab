clc;
clear;
clf;

function A = create_graph(n, density)
    A = zeros(n,n);
    for i = 1:n
        for j = i+1:n
            if rand() < density then
                w = grand(1,1,"uin",1,20);
                A(i,j) = w;
                A(j,i) = w;
            end
        end
    end
endfunction

function dist = dijkstra(A, src)
    n = size(A,1);
    dist = ones(n,1)*%inf;
    visited = zeros(n,1);
    dist(src) = 0;

    for i = 1:n
        minval = %inf;
        u = -1;
        for j = 1:n
            if visited(j)==0 & dist(j)<minval then
                minval = dist(j);
                u = j;
            end
        end

        if u==-1 then break; end
        visited(u) = 1;

        for v = 1:n
            if A(u,v)>0 then
                if dist(u)+A(u,v) < dist(v) then
                    dist(v) = dist(u)+A(u,v);
                end
            end
        end
    end
endfunction

function dist = bellman_ford(A, src)
    n = size(A,1);
    dist = ones(n,1)*%inf;
    dist(src) = 0;

    for k = 1:n-1
        for u = 1:n
            for v = 1:n
                if A(u,v)>0 then
                    if dist(u)+A(u,v) < dist(v) then
                        dist(v) = dist(u)+A(u,v);
                    end
                end
            end
        end
    end
endfunction

nodes = 5:5:100;
time_dij = [];
time_bf = [];

for n = nodes
    
    A = create_graph(n, 0.3);
    src = 1;

    timer();
    dijkstra(A, src);
    time_dij($+1) = timer();

    timer();
    bellman_ford(A, src);
    time_bf($+1) = timer();

    disp("Completed for nodes: " + string(n));
end

plot(nodes, time_dij, '-ro');
plot(nodes, time_bf, '-b*');
legend("Dijkstra","Bellman-Ford");
xtitle("Routing Time Comparison", "Number of Nodes", "Time (seconds)");
