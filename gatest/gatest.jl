# 本脚本用于运行GA代码

include(pwd()*"\\gatest\\creatures.jl")
include(pwd()*"\\gatest\\crossovermutation.jl")
include(pwd()*"\\gatest\\selection.jl")

tic() # 计算开始时间

const ngen = 100 # 最高演化代数

gafile = open(pwd()*"\\output\\ga.log","w")
gen = 1
minpower = zeros(Float64,ngen)
avepower = zeros(Float64,ngen)
minro = Array{Rotor}(ngen)
print("===初始化随机旋翼实例===\n")
x2ro = initcre()
while gen<=ngen
    seltmp = selection(ncre,npare,x2ro)
    x2ro_pa = seltmp[1]
    minpower[gen] = seltmp[2]
    avepower[gen] = seltmo[3]
    minro[gen] = seltmp[4]
    x2ro_child = crossover(nchil,x2ro_pa)
    x2ro = append!(x2ro_pa,x2ro_child)
    gen = gen+1
    print("===第$(gen)代进化完成\n")
    print("===当代最小功率为$(minpower[gen]);对应实例参数为$(minro[gen])===\n")
    print("===当代平均功率为$(avepower[gen])===\n\n")
end

close(gafile)
toc() # 计算结束时间
