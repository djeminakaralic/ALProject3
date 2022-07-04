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

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(MobilePhone_Cust; MobilePhone_Cust)
            {
                Caption = 'Broj mobilnog telefona';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(Email_Cust; Email_Cust)
            {
                Caption = 'E-mail';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(Address_Cust; Address_Cust)
            {
                Caption = 'Adresa';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(City_Cust; City_Cust)
            {
                Caption = 'Grad';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }

            /*field(Balance_Cust; Balance_Cust)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                trigger OnDrillDown()
                var
                    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    DtldCustLedgEntry.SetRange("Customer No.", "Account No.");
                    CopyFilter(CustomerTable."Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    CopyFilter(CustomerTable."Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                    CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                end;
            }*/
        }
    }

    var
        CustomerTable: Record Customer;
}