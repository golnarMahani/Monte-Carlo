function [ valuefunction ] = MC_FV_PE( p_s_a,gamma )
valuefunction=zeros(1,6);
visited=zeros(1,6);
count=1;
while(count<50)
    %% generate an episode
    state=randi([2 5],1);
    episode=state;
    rewards=0;
    returns=zeros(1,6);
    while(state~=1 && state~=6)
        action= sum(rand >= cumsum([0, p_s_a(state,1), p_s_a(state,2)]));
        [state,reward]=garbageEnv(action,state);
        episode=[episode ,state];
        rewards=[rewards ,reward];        
    end
    disp(['episode' num2str(count)]);
    disp(episode);
    rewards(1)=[];
    %% return calculation for each episode--first visit approach
    epi_states=unique(episode);
    epi_states(epi_states==6 | epi_states==1)=[];
    for i=1:size(epi_states,2),
        counter=0;
        for s=find(episode==epi_states(i),1,'first'):size(episode,2)-1,
           returns(epi_states(i))=returns(epi_states(i))+rewards(s)*gamma^counter;
           counter=counter+1;
        end        
        visited(epi_states(i))=visited(epi_states(i))+1;         
        valuefunction(epi_states(i))=((visited(epi_states(i))-1)*valuefunction(epi_states(i))+returns(epi_states(i)))/visited(epi_states(i));        
        
        disp(valuefunction);
    end
    count=count+1;
end
end

