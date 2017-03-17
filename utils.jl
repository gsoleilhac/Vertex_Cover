function vertex_deg_equals_x(G, x)
    for i = 1:size(G,1)
        if count(x -> x==1, G[i,:]) == x
            return i
        end
    end
    return 0
end

function vertex_deg_geq_than_x(G, x)
    for i = 1:size(G,1)
        if count(x -> x==1, G[i,:]) >= x
            return i
        end
    end
    return 0
end

function voisins(G, ind)
    return find(G[ind,:])
end


function del_neighbour_edges!(G, ind)
    for i = 1:size(G,1)
        G[i,ind] = 0
        G[ind,i] = 0
    end
end


function random_graph(n, p)
    G = zeros(Int, n, n)
    for i = 1:n-1, j = i+1:n
        if rand() < p
            G[i,j] = 1
            G[j,i] = 1
        end
    end
    return G
end

function deg(G,ind)
    return sum(G[ind,:])
end

function pick_edge_max(G)
    max = 0
    res = (0,0)
    n = size(G,1)
    for i = 1:n-1, j = i+1:n
        if G[i,j]==1
            sum_deg = deg(G,i) + deg(G,j)
            if sum_deg > max
                max = sum_deg
                res = (i,j)
            end
        end
    end
    return res
end

function is_VC(G, VC)
    for u = 1:size(G,1)
        if !(u in VC)
            for v in voisins(G, u)
                if !(v in VC)
                    return false
                end
            end
        end
    end
    return true
end

function count_edges(G)
    return count(x->x==1, G)/2
end
