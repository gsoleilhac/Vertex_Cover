typealias T UInt8
immutable Graph
    ind::Vector{T}
    m::BitMatrix
end

function vertex_deg_equals_x(G::Graph, x::Integer)::T
    for i in G.ind
        if count(x -> x==1, G.m[i,G.ind]) == x
            return i
        end
    end
    return T(0)
end

function vertex_deg_geq_than_x(G::Graph, x::Integer)::T
    for i in G.ind
        if count(x -> x==1, G.m[i,G.ind]) >= x
            return i
        end
    end
    return T(0)
end

function voisins(G::Graph, u::T)::Set{T}
    if !(u in G.ind) 
        return Set{T}()
    else
       res = Set{T}()
       for v in G.ind
            if G.m[u, v] == 1
                push!(res, v)
            end
        end
        return res
    end
end


function del_neighbour_edges!(G::Graph, u::T)::Void
    # !(u in G.ind) && error("sommet déja supprimé !")
    deleteat!(G.ind, findfirst(G.ind, u))
    return nothing
end


function random_graph(n::Integer, p::Real)::Graph
    m = falses(n, n)
    for i = 1:n-1, j = i+1:n
        if rand() < p
            m[i,j] = 1
            m[j,i] = 1
        end
    end
    ind = collect(T,1:n)

    #assert there is no unconnected vertex
    for i = 1:n
        if sum(m[i,:]) == 0
            deleteat!(ind, findfirst(ind, i))
        end
    end
    return Graph(ind,m)
end

function deg(G::Graph,u::Integer)::Integer
    if !(u in G.ind) 
        return 0
    else
        return sum(G.m[u,G.ind])
    end
end

function pick_edge_max(G::Graph)::Tuple{T,T}
    max = 0
    res = (T(0),T(0))
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

function is_VC(G::Graph, VC::Set{T})
    for u::T = 1:size(G.m,1)
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

function count_edges(G::Graph)::Integer
    return sum(G.m[G.ind, G.ind]) ÷ 2
end


function show_graph(G::Graph)::Void
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
    return nothing
end

function signif(x::Real, n::Integer)
    n <= 0 && error("n must be a positive integer")

    if x < 0 
        res = signif(-x, n)
        return "-$res"
    end

    if x > 1.0
        if n > log(10,x)
            return "$(round(x,n - ceil(Int,log(10,x))))"
        else
            return "$(round(x / 10^floor(Int,log(10,x)), n-1))e$(floor(Int,log(10,x)))"
        end
    else
        l = findfirst(x -> x!='0' && x!='.', "$x") + n - 3 # -2 pour qu'on ne compte pas le "0." 
                                                            #et -1 parcequ'on a déja compté le premier chiffre significatif -> -3
        res = "$(round(x, l))"
        return res
    end
end
