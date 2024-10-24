package com.my.org.erp.bean.Attendance;
public  final class State {
	int stateId;
	String stateName;
	String stateDes;
	public State(int stateId, String stateName, String stateDes) {
		super();
		this.stateId = stateId;
		this.stateName = stateName;
		this.stateDes = stateDes;
	}
	public State() {
		 
	}
	public String getStateDes() {
		return stateDes;
	}
   public void setStateDes(String stateDes) {
		this.stateDes = stateDes;
	}
	public int getStateId() {
		return stateId;
	}
	public void setStateId(int stateId) {
		this.stateId = stateId;
	}
	public String getStateName() {
		return stateName;
	}
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
}
