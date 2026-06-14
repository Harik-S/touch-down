function fuelMass = robustTest(H_t, V_t, h_i, v_i, dh, dv)
    pass_test=true;
    v_range = [v_i-dv,v_i+dv];
    h_range = [h_i-dh,h_i+dh];
    for hp = h_range
        for vp = v_range
            [partial_pass,~]=Lander(H_t,V_t,hp,vp);
            pass_test = partial_pass && pass_test;
        end
    end
    if (pass_test)
        [~,fuelMass]=Lander(H_t,V_t,h_i,v_i);
    else
        fuelMass = -1e5;
    end
end