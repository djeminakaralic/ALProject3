pageextension 50147 JournalLineDetailsFactBox extends "Journal Line Details FactBox"
{
    layout
    {
        modify(Account)
        {
            Caption = 'Podaci o kupcu';
        }
        modify(AccountName)
        {
            Caption = 'Ime i prezime';
        }
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
        addafter(AccountName)
        {
            field(Address_Cust; Address_Cust)
            {
                Caption = 'Adresa';
                ApplicationArea = All;
            }
            field(City_Cust; City_Cust)
            {
                Caption = 'Grad';
                ApplicationArea = All;
            }
            field(Phone_Cust; Phone_Cust)
            {
                Caption = 'Kućni telefonski broj';
                ApplicationArea = All;
            }
            field(MobilePhone_Cust; MobilePhone_Cust)
            {
                Caption = 'Broj mobilnog telefona';
                ApplicationArea = All;
            }
        }
    }

    actions
    {

    }

    var
}