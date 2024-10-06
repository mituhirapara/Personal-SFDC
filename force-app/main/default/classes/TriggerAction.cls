public class TriggerAction {
    
	public interface BeforeInsert {
		void beforeInsert(List<sObject> newItems);
	}

	public interface AfterInsert {
		void afterInsert(Map<Id, sObject> newItems);
	}

    public interface BeforeUpdate {
		void beforeUpdate(Map<Id, sObject> newItems, Map<Id, sObject> oldItems);
	}

	public interface AfterUpdate {
		void afterUpdate(Map<Id, sObject> newItems, Map<Id, sObject> oldItems);
	}

    public interface BeforeDelete {
		void beforeDelete(Map<Id, sObject> oldItems);
	}

	public interface AfterDelete {
		void afterDelete(Map<Id, sObject> oldItems);
	}

	public interface AfterUndelete {
		void afterUndelete(Map<Id, sObject> newItems);
	}
}