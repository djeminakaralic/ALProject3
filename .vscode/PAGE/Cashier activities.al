page 50110 "Cashier Activities"
{
    Caption = 'Cashier Activities';
    PageType = CardPart;
    SourceTable = "Cashier Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }

            field("Cash Receipt Journal"; "Cash Receipt Journal")
            {
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    Page.Run(255);
                end;
            }

            cuegroup(BankAccounts)
            {
                Caption = 'Bank Accounts';
                field("All Bank Accounts"; "All Bank Accounts")
                {
                    ApplicationArea = all;
                }
                field("Bank Accounts"; "Bank Accounts")
                {
                    ApplicationArea = all;
                }
                field(CZK; CZK)
                {
                    ApplicationArea = all;
                }
            }

            cuegroup(AllCustomers)
            {
                Caption = 'Customers';
                field(Customers; Customers)
                {
                    ApplicationArea = all;
                }
            }

        }
    }

    var

}

