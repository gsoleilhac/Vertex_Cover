typealias T Int16  #typemax(UInt16) = 65535

immutable Graph
    ind::Vector{T} #Contient les indices des sommets encore présents dans le graphe
    m::BitMatrix #Matrice d'adjacence
end

#Crée un graphe avec la même matrice que G mais une copie de ses indices
function Base.copy(G::Graph)::Graph
    return Graph(Base.copy(G.ind), G.m)
end


#Retourne le premier sommet trouvé de degré == x
function vertex_deg_equals_x(G::Graph, x::Integer)::T
    for i in G.ind
        if count(x -> x==1, view(G.m,i,G.ind)) == x
            return i
        end
    end
    return T(0)
end


#Retourne le premier sommet trouvé de degré >= x
function vertex_deg_geq_than_x(G::Graph, x::Integer)::T
    for i in G.ind
        if count(x -> x==1, view(G.m,i,G.ind)) >= x
            return i
        end
    end
    return T(0)
end


#Retourne le sommet de degré max et son degré
function vertex_deg_max(G::Graph)::Tuple{T,Integer}
    u,deg_u = T(0),0
    for i in G.ind
        deg_i = count(x -> x==1, view(G.m,i,G.ind))
        if deg_i >= deg_u
            u,deg_u = i,deg_i
        end
    end
    return (u,deg_u)
end

#Retourne tous les sommets adjacents à u
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

#Supprime toutes les arretes adjacents à u
#Cela revient à enlever u de la liste des sommets
#On vérifie pour tous les voisins de u que leur degré n'est pas nul
#S'il est nul on supprime aussi ce sommet
function del_neighbour_edges!(G::Graph, u::T)::Void
    if u in G.ind
        nb = voisins(G, u)
        deleteat!(G.ind, findfirst(G.ind, u))
        for v in nb
            deg(G,v) == 0 && del_neighbour_edges!(G, v)
        end
    end
    return nothing
end

#Retourne un graphe de taille n x n, 
#chaque arrete [i,j] (j > i) existe avec une probabilité p
function random_graph(n::Integer, p::Real)::Graph
    m = falses(n, n)
    for i = 1:n-1, j = i+1:n
        if rand() < p
            m[i,j] = 1
            m[j,i] = 1
        end
    end
    ind = collect(T,1:n)

    #Si un sommet a un degré nul, on l'enleve de la liste des sommets
    for i = 1:n
        if sum(view(m,i,:)) == 0
            deleteat!(ind, findfirst(ind, i))
        end
    end
    return Graph(ind,m)
end

#Retourne le degré du sommet u
function deg(G::Graph,u::Integer)::Integer
    !(u in G.ind) && return 0
    return sum(view(G.m,u,G.ind))
end

#Pour GLOUTON_VC
#Renvoie les sommets (u,v) maximisant deg(u)+deg(v) avec u et v voisins.
function pick_edge_max(G::Graph)::Tuple{T,T}
    max = 0
    res = (T(0),T(0))
    n = length(G.ind)
    degres = map(x -> deg(G,x), G.ind)
    for i = 1:n-1
        vi = G.ind[i]
        for j = i+1:n
            vj = G.ind[j]
            if G.m[vi,vj] == 1
                sum_deg = degres[i] + degres[j]
                if sum_deg > max
                    max = sum_deg
                    res = (vi,vj)
                end
            end
        end
    end
    return res
end

#Renvoie true si VC est un Vertex Cover pour le graphe G
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

#Renvoie le nombre d'arretes dans le graphe
function count_edges(G::Graph)::Integer
    return sum(G.m[G.ind, G.ind]) ÷ 2
end


#Affichage pour visualiser les sommets encore dans le graphe
#Nécéssite de lancer julia avec l'option --color=yes
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


#Pour afficher les résultats avec n chiffres significatifs
function signif(x::Real, n::Integer)::String
    n <= 0 && error("n must be a positive integer")

    if x < 0 
        res = signif(-x, n)
        return "-$res"
    end

    if x > 1.0
        if n > log(10,x)
            return "$(round(x,n - ceil(Int,log(10,x))))"
        else
            # return "$(round(x / 10^floor(Int,log(10,x)), n-1))e$(floor(Int,log(10,x)))"
            return "$(round(Int,x))"
        end
    else
        if x >= 1e-4
            l = findfirst(x -> x!='0' && x!='.', "$x") + n - 3 # -2 pour qu'on ne compte pas le "0." 
                                                                #et -1 parcequ'on a déja compté le premier chiffre significatif donc -3
            res = "$(round(x, l))"
            return res
        else #si x < 0.0001 "$x" est sous forme d'une puissance de 10
            if findfirst(c -> c=='e', "$x") <= n + 2
                return "$x"
            else
                i = -5

                while x < 10.0^i
                    i -= 1
                end

                # 10^(i+1) < x <= 10^(i)

                return "$(round(x, -i + n - 1))"
            end
        end
    end
end
