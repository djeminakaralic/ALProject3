pageextension 50147 JournalLineDetailsFactBox extends "Journal Line Details FactBox"
{
    layout
    {
        modify(PostingGroup)
        {
            Visible = false;
        }
        modify(GenPostingSetup)
        {
            Visible = false;
        }
        modify(VATPostingSetup)
        {
            Visible = false;
        }
        modify(BalAccount)
        {
            Visible = false;
        }
        //modify()
        addafter(AccountName)
        {
            field(Address_Cust; Address_Cust)
            {
                ApplicationArea = All;
            }
            field(City_Cust; City_Cust)
            {
                ApplicationArea = All;
            }
            field(Phone_Cust; Phone_Cust)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {

    }

    var
}