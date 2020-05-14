function Out = Sincroniza(Tmsg1,Tmsg2,VettoSinc)
%% sincroniza os vetores do log pelo tempo que é enviado cada mensagem
ax = 1;
i  = 1;
while i <=length(Tmsg1)
    j = ax;
    while j<length(Tmsg2)
        if(Tmsg1(i) < Tmsg2(j))
            Out(i) = VettoSinc(j);
            if(j>1)
                ax = j-1;
            end
            j = length(Tmsg2);
        end
        j = j+1;
    end
    i = i+1;
end

if(length(Out)<length(Tmsg1))
    Out(end+1) = Out(end);
end
end
