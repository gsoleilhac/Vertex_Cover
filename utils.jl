type Graph
    ind::Array{Int}
    m::Matrix{Int}
end

function vertex_deg_equals_x(G, x)
    for i in G.ind
        if count(x -> x==1, G.m[i,G.ind]) == x
            return i
        end
    end
    return 0
end

function vertex_deg_geq_than_x(G, x)
    for i in G.ind
        if count(x -> x==1, G.m[i,G.ind]) >= x
            return i
        end
    end
    return 0
end

function voisins(G, u)
    if !(u in G.ind) 
        return Int[]
    else
       res = Int[]
       for v in G.ind
            if G.m[u, v] == 1
                push!(res, v)
            end
        end
        return res
    end
    #return find(G.m[u,G.ind])
end


function del_neighbour_edges!(G, u)
    !(u in G.ind) && error("sommet déja supprimé !")
    deleteat!(G.ind, findfirst(G.ind, u))
end


function random_graph(n, p)
    m = zeros(Int, n, n)
    for i = 1:n-1, j = i+1:n
        if rand() < p
            m[i,j] = 1
            m[j,i] = 1
        end
    end
    ind = collect(1:n) 
    #TODO assert there is no unconnected vertex here
    for i = 1:n
        if sum(m[i,:]) == 0
            deleteat!(ind, findfirst(ind, i))
        end
    end
    return Graph(ind,m)
end

function deg(G,u)
    if !(u in G.ind) 
        return 0
    else
        return sum(G.m[u,G.ind])
    end
end

function pick_edge_max(G)
    max = 0
    res = (0,0)
    n = length(G.ind)
    for i = 1:n-1
        vi = G.ind[i]
        deg_vi = deg(G,vi)
        for j = i+1:n
            vj = G.ind[j]
            if G.m[vi,vj] == 1
                sum_deg = deg_vi + deg(G,vj)
                if sum_deg > max
                    max = sum_deg
                    res = (vi,vj)
                end
            end
        end
    end
    return res
end

function is_VC(G, VC)
    for u = 1:size(G.m,1)
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
    return sum(G.m[G.ind, G.ind]) ÷ 2
end


function show_graph(G)
    println()
    for i = 1:size(G.m,1)
        for j = 1:size(G.m,1)
            if i in G.ind && j in G.ind
                print_with_color(:blue, "$(G.m[i,j]) ")
            else
                print_with_color(:red, "$(G.m[i,j]) ")
            end
        end
        println()
    end
    println()
end