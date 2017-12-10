# 本脚本用于交叉父辈的染色体生成子辈

function muterate(gen,mutrate,ngen)
    # 变异率方程；认为变异开始会是一个较高水平；但是会随着种群的增长逐渐降低
    return 0.24*cos(π/ngen*gen)+0.26
end

function crossover(gen,mutrate,ngen,nchil,pare::Array)
    childtmp = Array{Rotor}(nchil)
    k = 1
    # 父辈两两相交生成子辈
    for i in 1:npare
        for j in 1:npare
            if i==j
                continue
            else
                if rand()>=muterate(gen,mutrate,ngen)  # 如果随机数大于变异率则不变异
                    chroot = pare[i].chroot.v+pare[j].chroot.v
                    taper = pare[i].taper.v+pare[j].taper.v
                    taperr = pare[i].taperr.v+pare[j].taperr.v
                    twist1 = pare[i].twist1.v+pare[j].twist1.v
                    twist2 = pare[i].twist2.v+pare[j].twist2.v
                    twistr = pare[i].twistr.v+pare[j].twistr.v
                    cichroot = Ropara(chroot/2,0.05,0.10)
                    citaper  = Ropara(taper/2,0.6,1.0)
                    citaperr = Ropara(taperr/2,0.1*R,0.9*R)
                    citwist1 = Ropara(twist1/2,-20.0/180*π,-5.0/180*π)
                    citwist2 = Ropara(twist2/2,-20.0/180*π,-5.0/180*π)
                    citwistr = Ropara(twistr/2,0.1*R,0.8*R)
                    childtmp[k] = Rotor(cichroot,citaper,citaperr,citwist1,citwist2,citwistr,fitness)
                else                # 否则随机变异
                    chroot = Ropara(0.0,0.05,0.10)
                    taper  = Ropara(0.0,0.6,1.0)
                    taperr = Ropara(0.0,0.1*R,0.9*R)
                    twist1 = Ropara(0.0,-20.0/180*π,5.0/180*π)
                    twist2 = Ropara(0.0,-20.0/180*π,5.0/180*π)
                    twistr = Ropara(0.0,0.1*R,0.8*R)
                    childtmp[k] = Rotor(chroot,taper,taperr,twist1,twist2,twistr,fitness)
                end
                while true  # 判断子辈是否满足约束条件，不满足则变异直到满足
                    if !constraint(childtmp[k])
                        chroot = Ropara(0.0,0.05,0.10)
                        taper  = Ropara(0.0,0.6,1.0)
                        taperr = Ropara(0.0,0.1*R,0.9*R)
                        twist1 = Ropara(0.0,-20.0/180*π,5.0/180*π)
                        twist2 = Ropara(0.0,-20.0/180*π,5.0/180*π)
                        twistr = Ropara(0.0,0.1*R,0.8*R)
                        childtmp[k] = Rotor(chroot,taper,taperr,twist1,twist2,twistr,fitness)
                    else
                        break
                    end
                end
                k = k+1
            end
        end
    end

    return childtmp
end
