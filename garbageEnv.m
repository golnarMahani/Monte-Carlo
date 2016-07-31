function [ state,reward ] = garbageEnv( action,current_state )

%% Calculating the New position
if(current_state~=6 && current_state~=1)
    %the occurenece of the real action, with probabilities of 0.05,0.15 and 0.8
    actual_action= sum(rand >= cumsum([0, 0.05, 0.15, 0.8]));
    %update robot position
    if(actual_action==1)
        if(action==1) %right
            state=current_state-1;
        else %left
            state=current_state+1;
        end
    elseif(actual_action==2)    
        state=current_state;    
    elseif(actual_action==3)
        if(action==1) %right
            state=current_state+1;
        else %left
            state=current_state-1;
        end
    end
else
    state=current_state;
end

%% the reward
if(current_state==state)
    reward=0;
elseif(state==1)
    reward=1;
elseif(state==6)
    reward=5;
else
    reward=0;
end
end

