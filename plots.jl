using PyPlot
f = readcsv("data.csv")
nblignes = 11*6

greed_4╱n = convert(Vector{Float64},f[map(x -> x%6==1, collect(1:nblignes)), 5])
greed_5╱n = convert(Vector{Float64},f[map(x -> x%6==2, collect(1:nblignes)), 5])
greed_logn╱n = convert(Vector{Float64},f[map(x -> x%6==3, collect(1:nblignes)), 5])
greed_1╱⎷n = convert(Vector{Float64},f[map(x -> x%6==4, collect(1:nblignes)), 5])
greed_01 = convert(Vector{Float64},f[map(x -> x%6==5, collect(1:nblignes)), 5])
greed_02 = convert(Vector{Float64},f[map(x -> x%6==0, collect(1:nblignes)), 5])

greed_4╱n_val = convert(Vector{Int},f[map(x -> x%6==1, collect(1:nblignes)), 6])
greed_5╱n_val = convert(Vector{Int},f[map(x -> x%6==2, collect(1:nblignes)), 6])
greed_logn╱n_val = convert(Vector{Int},f[map(x -> x%6==3, collect(1:nblignes)), 6])
greed_1╱⎷n_val = convert(Vector{Int},f[map(x -> x%6==4, collect(1:nblignes)), 6])
greed_01_val = convert(Vector{Int},f[map(x -> x%6==5, collect(1:nblignes)), 6])
greed_02_val = convert(Vector{Int},f[map(x -> x%6==0, collect(1:nblignes)), 6])

IPL_4╱n = convert(Vector{Float64},f[map(x -> x%6==1, collect(1:nblignes)), 7])
IPL_5╱n = convert(Vector{Float64},f[map(x -> x%6==2, collect(1:nblignes)), 7])
IPL_logn╱n = convert(Vector{Float64},f[map(x -> x%6==3, collect(1:nblignes)), 7])
IPL_1╱⎷n = convert(Vector{Float64},f[map(x -> x%6==4, collect(1:nblignes)), 7])
IPL_01 = convert(Vector{Float64},f[map(x -> x%6==5, collect(1:nblignes)), 7])
IPL_02 = convert(Vector{Float64},f[map(x -> x%6==0, collect(1:nblignes)), 7])

IPL_4╱n_val = convert(Vector{Int},f[map(x -> x%6==1, collect(1:nblignes)), 8])
IPL_5╱n_val = convert(Vector{Int},f[map(x -> x%6==2, collect(1:nblignes)), 8])
IPL_logn╱n_val = convert(Vector{Int},f[map(x -> x%6==3, collect(1:nblignes)), 8])
IPL_1╱⎷n_val = convert(Vector{Int},f[map(x -> x%6==4, collect(1:nblignes)), 8])
IPL_01_val = convert(Vector{Int},f[map(x -> x%6==5, collect(1:nblignes)), 8])
IPL_02_val = convert(Vector{Int},f[map(x -> x%6==0, collect(1:nblignes)), 8])

IP_4╱n = convert(Vector{Float64},f[map(x -> x%6==1, collect(1:nblignes)), 9])
IP_5╱n = convert(Vector{Float64},f[map(x -> x%6==2, collect(1:nblignes)), 9])
IP_logn╱n = convert(Vector{Float64},f[map(x -> x%6==3, collect(1:nblignes)), 9])
IP_1╱⎷n = convert(Vector{Float64},f[map(x -> x%6==4, collect(1:nblignes)), 9])
IP_01 = convert(Vector{Float64},f[map(x -> x%6==5, collect(1:nblignes)), 9])
IP_02 = convert(Vector{Float64},f[map(x -> x%6==0, collect(1:nblignes)), 9])

KERNEL_4╱n = convert(Vector{Float64},f[map(x -> x%6==1, collect(1:nblignes)), 10])
KERNEL_5╱n = convert(Vector{Float64},f[map(x -> x%6==2, collect(1:nblignes)), 10])
KERNEL_logn╱n = convert(Vector{Float64},f[map(x -> x%6==3, collect(1:nblignes)), 10])
KERNEL_1╱⎷n = convert(Vector{Float64},f[map(x -> x%6==4, collect(1:nblignes)), 10])
KERNEL_01 = convert(Vector{Float64},f[map(x -> x%6==5, collect(1:nblignes)), 10])
KERNEL_02 = convert(Vector{Float64},f[map(x -> x%6==0, collect(1:nblignes)), 10])

ARB_4╱n = convert(Vector{Float64},f[map(x -> x%6==1, collect(1:nblignes)), 11])
ARB_5╱n = convert(Vector{Float64},f[map(x -> x%6==2, collect(1:nblignes)), 11])
ARB_logn╱n = convert(Vector{Float64},f[map(x -> x%6==3, collect(1:nblignes)), 11])
ARB_1╱⎷n = convert(Vector{Float64},f[map(x -> x%6==4, collect(1:nblignes)), 11])
ARB_01 = convert(Vector{Float64},f[map(x -> x%6==5, collect(1:nblignes)), 11])
ARB_02 = convert(Vector{Float64},f[map(x -> x%6==0, collect(1:nblignes)), 11])

VAL_4╱n = convert(Vector{Int},f[map(x -> x%6==1, collect(1:nblignes)), 12])
VAL_5╱n = convert(Vector{Int},f[map(x -> x%6==2, collect(1:nblignes)), 12])
VAL_logn╱n = convert(Vector{Int},f[map(x -> x%6==3, collect(1:nblignes)), 12])
VAL_1╱⎷n = convert(Vector{Int},f[map(x -> x%6==4, collect(1:nblignes)), 12])
VAL_01 = convert(Vector{Int},f[map(x -> x%6==5, collect(1:nblignes)), 12])
VAL_02 = convert(Vector{Int},f[map(x -> x%6==0, collect(1:nblignes)), 12])


N = [10,20,30,40,50,60,70,80,90,100,120]

# plot(N, ARB_4╱n, "r-", label="ARB 4/n")
# plot(N, ARB_5╱n, "b-", label="ARB 5/n")
# plot(N, ARB_logn╱n, "m-", label="ARB log(n)/n")
# plot(N, ARB_1╱⎷n, "c-", label="ARB 1/√n")
# plot(N, ARB_01, "w-", label="ARB 0.1")
# plot(N, ARB_02, "y-", label="ARB 0.2")

# plot(N, KERNEL_4╱n, "r--", label="KERNEL 4/n")
# plot(N, KERNEL_5╱n, "b--", label="KERNEL 5/n")
# plot(N, KERNEL_logn╱n, "m--", label="KERNEL log(n)/n")
# plot(N, KERNEL_1╱⎷n, "c--", label="KERNEL 1/√n")
# plot(N, KERNEL_01, "w--", label="KERNEL 0.1")
# plot(N, KERNEL_02, "y--", label="KERNEL 0.2")

# legend()
# show()


# plot(N, greed_4╱n, "r-", label="greed 4/n")
# plot(N, greed_5╱n, "b-", label="greed 5/n")
# plot(N, greed_logn╱n, "m-", label="greed log(n)/n")
# plot(N, greed_1╱⎷n, "c-", label="greed 1/√n")
# plot(N, greed_01, "w-", label="greed 0.1")
# plot(N, greed_02, "y-", label="greed 0.2")

# plot(N, IPL_4╱n, "r--", label="IPL 4/n")
# plot(N, IPL_5╱n, "b--", label="IPL 5/n")
# plot(N, IPL_logn╱n, "m--", label="IPL log(n)/n")
# plot(N, IPL_1╱⎷n, "c--", label="IPL 1/√n")
# plot(N, IPL_01, "w--", label="IPL 0.1")
# plot(N, IPL_02, "y--", label="IPL 0.2")

# legend()
# show()


# plot(N, greed_4╱n_val ./ VAL_4╱n, "r-", label="p =  4/n")
# plot(N, greed_5╱n_val ./ VAL_5╱n, "b-", label="p =  5/n")
# plot(N, greed_logn╱n_val ./ VAL_logn╱n, "m-", label="p =  log(n)/n")
# plot(N, greed_1╱⎷n_val ./ VAL_1╱⎷n, "c-", label="p =  1/√n")
# plot(N, greed_01_val ./ VAL_01, "w-", label="p =  0.1")
# plot(N, greed_02_val ./ VAL_02, "y-", label="p =  0.2")


bar(
    left = [0.5,1,1.5, 3.5,4,4.5, 6.5,7,7.5, 9.5,10,10.5, 12.5,13,13.5, 15.5,16,16.5], 
    width = [1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1], bottom = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], 
    height = [
    mean(greed_4╱n_val ./ VAL_4╱n),0,
    mean(IPL_4╱n_val ./ VAL_4╱n), 
    mean(greed_5╱n_val ./ VAL_5╱n),0,
    mean(IPL_5╱n_val ./ VAL_5╱n),
    mean(greed_logn╱n_val ./ VAL_logn╱n),0,
    mean(IPL_logn╱n_val ./ VAL_logn╱n),
    mean(greed_1╱⎷n_val ./ VAL_1╱⎷n),0,
    mean(IPL_1╱⎷n_val ./ VAL_1╱⎷n),
    mean(greed_01_val ./ VAL_01),0,
    mean(IPL_01_val ./ VAL_01),
    mean(greed_02_val ./ VAL_02),0,
    mean(IPL_02_val ./ VAL_02)
    ],
    tick_label = ["","4/n","", "","5/n","", "","log(n)/n","", "","1/√n","", "","0.1","", "","0.2",""],
    color = ["r","c", "b","r","c","b","r","c","b","r","c","b","r","c","b","r","c","b"],
    edgecolor = "k"
    )

xlabel("p")
ylabel("Ratio moyen")


legend([line_up, line_down], ["Line Up", "Line Down"])
show()


