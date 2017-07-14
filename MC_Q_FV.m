function [ Q_s_a ] = MC_Q_FV( p_s_a,gamma )
Q_s_a=zeros(2,6);
returns=zeros(2,6);
visited=zeros(2,6);
count=1;
while(count<200)
    %% generate an episode
    state=randi([2 5],1);
    episode=state;
    rewards=0;
    actions=0;
    while(state~=1 && state~=6)
        action= sum(rand >= cumsum([0, p_s_a(state,1), p_s_a(state,2)]));
        [state,reward]=garbageEnv(action,state);
        episode=[episode ,state];
        rewards=[rewards ,reward]; 
        actions=[actions ,action];        
    end
    disp(['episode' num2str(count)]);
    disp(episode);
    rewards(1)=[];
    actions(1)=[];
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
        disp('qsa for');
        disp('state:');
        disp(epi_states(i,1));
        disp('action:')
        disp(epi_states(i,2));
        disp(Q_s_a);
    end
    count=count+1;
end

end

