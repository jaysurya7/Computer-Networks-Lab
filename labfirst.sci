clear;
clc;

// Node sizes
nodes = 5:5:100;

// Store time
time_bf = [];
time_dj = [];

// Loop for each network size
for n = nodes

    // Create random adjacency matrix
    A = rand(n,n);
    A = round(A*10);  // weights

    // -----------------------------
    // Bellman-Ford (simple loop)
    // -----------------------------
    t1 = timer();

    dist = ones(1,n) * %inf;
    dist(1) = 0;

    for i = 1:n-1
        for u = 1:n
            for v = 1:n
                if dist(u) + A(u,v) < dist(v) then
                    dist(v) = dist(u) + A(u,v);
                end
            end
        end
    end

    t_bf = timer() - t1;
    time_bf = [time_bf t_bf];

    // -----------------------------
    // Dijkstra (simple version)
    // -----------------------------
    t2 = timer();

    dist = ones(1,n) * %inf;
    dist(1) = 0;

    visited = zeros(1,n);

    for i = 1:n
        [min_val, u] = min(dist);
        visited(u) = 1;

        for v = 1:n
            if dist(u) + A(u,v) < dist(v) then
                dist(v) = dist(u) + A(u,v);
            end
        end
    end

    t_dj = timer() - t2;
    time_dj = [time_dj t_dj];

end

// -----------------------------
// Plot graph
// -----------------------------
plot(nodes, time_bf, '-r');
plot(nodes, time_dj, '-b');

legend("Bellman Ford", "Dijkstra");
xlabel("Number of Nodes");
ylabel("Time");
title("Routing Algorithm Comparison");
