using JuMP
using CPLEX


function IPL_VC(G; relax = true)

    m = Model(solver = CplexSolver())
    n = size(G.m,1)
    @variable(m, 0 <= x[1:n] <= 1, Int)
    @objective(m, Min, sum(x[i] for i = 1:n))
    for i=1:n-1, j=i+1:n
        if G.m[i,j] == 1
            @constraint(m, x[i] + x[j] >= 1)
        end
    end
    solve(m, relaxation=relax)
    z = getobjectivevalue(m)
    sol = getvalue(x)

    return find(x -> x >= 0.5, sol)
end


 