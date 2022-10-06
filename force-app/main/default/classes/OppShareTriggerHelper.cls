public with sharing class OppShareTriggerHelper {


//Add comments for project clarity

    public static void onAfterInsert(List<Opportunity> oppList) {
       
        Group userOrGroupId = [SELECT Id
        FROM Group
        WHERE Name = 'High Value Care Reps' AND Type = 'Regular' WITH SECURITY_ENFORCED LIMIT 1];

        List<OpportunityShare> oppShareList = new List<OpportunityShare>();

        for(Opportunity o: oppList) {
            if(o.Amount > 10000 && o.CurrencyIsoCode == 'USD' || 
                o.Amount > 7000 && o.CurrencyIsoCode == 'GBP' ) {

                OpportunityShare os = new OpportunityShare();

                os.OpportunityId = o.Id;
                os.UserOrGroupId = userOrGroupId.Id;
                os.OpportunityAccessLevel = 'Read';
                os.RowCause = Schema.OpportunityShare.RowCause.Manual;
                oppShareList.add(os);
            }
        }
        if(oppShareList.size() > 0) {
            Database.SaveResult[] oppShareInsert = Database.insert(oppShareList, false);
        }
    }



    //Bonus add afterUpdate class that follows similar logic as High Value Trigger
    //add to Opp trigger
}


 