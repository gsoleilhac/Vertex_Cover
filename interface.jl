include("utils.jl")
include("GLOUTON_VC.jl")
include("IPL_VC.jl")
include("ARB_VC.jl")
include("KERNEL_VC.jl")


precompile(GLOUTON_VC, (Graph,))
precompile(IPL_VC, (Graph,))
precompile(KERNEL_VC, (Graph,Int64))
precompile(ARB_VC, (Graph,Int64))

