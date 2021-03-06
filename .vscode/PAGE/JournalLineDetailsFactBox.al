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
            field("Social status"; "Social status")
            {
                Caption = 'Kategorija socijalnih slučajeva';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
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
            field(Balance_Cust; Balance_Cust)
            {
                Caption = 'Saldo';
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    DtldCustLedgEntry.Reset();
                    DtldCustLedgEntry.SetRange("Customer No.", "Account No.");

                    DtldCustLedgEntry.SetFilter("Initial Entry Global Dim. 1", '%1', GlobalDimension1Filter);
                    DtldCustLedgEntry.SetFilter("Initial Entry Global Dim. 2", '%1', GlobalDimension2Filter);
                    DtldCustLedgEntry.SetFilter("Currency Code", '%1', CurrencyFilter);

                    /*CopyFilter(CustomerTable."Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    CopyFilter(CustomerTable."Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");*/

                    CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                end;
            }
            /*field(Avans_Cust; Avans_Cust)
            {
                Caption = 'Avans';
                ApplicationArea = All;
            }
            field(Complaint; Complaint)
            {
                Caption = 'Tužbe';
                ApplicationArea = All;

                /*FILTERI SA KARTONA RADNIKA - RESIDENCE PERMIT
                trigger OnDrillDown()
                begin
                    PersonalDocuments.RESET;
                    PersonalDocuments.SETFILTER("Employee No.", "No.");
                    PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                    PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                    IF PersonalDocuments.FINDFIRST THEN BEGIN
                        PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                        PersonalDocumentsPage.RUN;
                    END
                    ELSE BEGIN
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                        PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                        PersonalDocumentsPage.RUN;
                    END;
                    CurrPage.UPDATE;
                end;*/

            /*}
            field(Interest; Interest)
            {
                Caption = 'Kamate';
                ApplicationArea = All;
            }*/
        }
    }
}