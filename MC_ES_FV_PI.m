function [ policy ] = MC_ES_FV_PI( p_s_a,gamma )
Q_s_a=zeros(2,6);
returns=zeros(2,6);
visited=zeros(2,6);
count=1;
while(count<1000)
    %% generate an episode with exploring start
    state=randi([2 5],1);    
    episode=state;
    actions=randi([1 2],1);
    [state,reward]=garbageEnv(actions,state);
    rewards=reward;
    episode=[episode ,state];        
    while(state~=1 && state~=6)        
        action= sum(rand >= cumsum([0, p_s_a(state,1), p_s_a(state,2)]));        
        [state,reward]=garbageEnv(action,state);
        rewards=[rewards ,reward]; 
        episode=[episode ,state];        
        actions=[actions ,action];        
    end
    disp(['episode' num2str(count)]);
    disp(episode);
    episode(size(episode,2))=[];
    epi_state_action=[episode',actions'];
    
    %% return calculation for each episode--first visit approach
    epi_states=unique(epi_state_action,'rows');
    epi_states(epi_states(:,1)==6 | epi_states(:,1)==1)=[];   
    returns=0;
    for i=1:size(epi_states,1),
        counter=0;
        [Lia, Locb] = ismember(epi_states(i,:),epi_state_action), 'rows');
        for s=Locb:size(epi_state_action,1),
           returns(epi_states(i,2),epi_states(i,1))=returns(epi_states(i,2),epi_states(i,1))+rewards(s)*gamma^counter;
           counter=counter+1;
        end
        visited(epi_states(i,2),epi_states(i,1))=visited(epi_states(i,2),epi_states(i,1))+1;                 
        Q_s_a(epi_states(i,2),epi_states(i,1))=((visited(epi_states(i,2),epi_states(i,1))-1)*Q_s_a(epi_states(i,2),epi_states(i,1))+returns(epi_states(i,2),epi_states(i,1)))/visited(epi_states(i,2),epi_states(i,1));
        disp('qsa');
        disp(Q_s_a);        
    end
    %% policy improvement for each state
    epi_states=unique(epi_state_action(:,1));
    for i=1:size(epi_states,1),
        if(Q_s_a(1,epi_states(i))>Q_s_a(2,epi_states(i)))
            p_s_a(epi_states(i),1)=1;
            p_s_a(epi_states(i),2)=0;
        elseif(Q_s_a(1,epi_states(i))<Q_s_a(2,epi_states(i)))
            p_s_a(epi_states(i),1)=0;
            p_s_a(epi_states(i),2)=1;
        end
    end
    count=count+1;
    disp('each psa');
    disp(p_s_a);
    
    %% display the updated policy
    policy=zeros(1,6);
    for i=2:5,
        if(p_s_a(i,1)==1)
            policy(i)=1;
        elseif(p_s_a(i,2)==1)
            policy(i)=2;
        end
    end
    disp(policy);
end


end

