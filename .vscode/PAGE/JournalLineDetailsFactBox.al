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


        addafter(AccountName)
        {
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
            field(Email_Cust; Email_Cust)
            {
                Caption = 'E-mail';
                ApplicationArea = All;
            }
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
            field("Posting Group"; "Posting Group")
            {
                Caption = 'Knjižna grupa';
                ApplicationArea = All;
            }
            /*field(Balance_Cust; Balance_Cust)
            {
                Caption = 'Saldo';
                ApplicationArea = All;
            }*/
        }
    }
}