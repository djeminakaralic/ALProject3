report 50185 "Specifikacija karticnog"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Specifikacija karticnog placanja.rdl';


    dataset
    {
        dataitem(DataItem21; "G/L Entry")
        {
            trigger OnPreDataItem()
            begin
                //BankAccCardFilter := GETFILTER("Bal. Account No.");
            end;
        }

        dataitem(DataItem22; "Bank Account")
        {
            column(BankNo; DataItem22."No.")
            {
            }
            column(BankName; DataItem22.Name)
            {
            }
            column(PaymentAmount; PaymentAmount)
            {
            }
            column(Show; Show)
            {
            }
            column(Datee; Datee)
            {
            }

            /*column(ReportTitle; ReportTitle)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(User; USERID)
            {
            }
            column(Counter; Counter)
            {
            }
            column(PTCounter; PTCounter)
            {
            }*/

            trigger OnAfterGetRecord()
            begin
                PaymentAmount := 0;
                Show := 0;

                //IF (DataItem22."No." = FILTER('CZK*')) then begin
                GLEntry.SetFilter("Bal. Account No.", '%1', DataItem22."No.");
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Payment Method", '%1', 'Kartično');
                //jos da je uplata
                if GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += GLEntry."Credit Amount";
                    until GLEntry.Next() = 0;
                Show := 1;
                //end;



                /*GLEntry.SetFilter("Bal. Account No.", '%1', BankAccCardFilter);
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Payment Type Code", '%1', DataItem22.Code);
                if select = Select::"POS terminali dnevni izvještaj" then begin
                    GLEntry.SetFilter("Payment Method", '%1', 'Kartično');
                    ReportTitle := 'DNEVNI IZVJEŠTAJ SA BLAGAJNE';
                    Show := 1;
                end else begin
                    ReportTitle := 'IZVJEŠTAJ PORTO BLAGAJNE Br. ';
                    Show := 2;
                end;

                PaymentCounter := GLEntry.Count;

                PaymentAmount := 0;

                IF GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += ABS(GLEntry.Amount);
                    until GLEntry.Next() = 0;

                Counter += 1;*/

            end;

            trigger OnPreDataItem()
            begin
                //BankAccount.SetFilter("No.", '%1', 'CZK*');
                //PTCounter := DataItem22.Count;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date")
                {
                    Caption = 'Datum izvještaja';
                    field(Datee; Datee)
                    {
                        Caption = 'Datum izvještaja: ';
                    }
                }

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        GLEntry: Record "G/L Entry";
        ReportTitle: Text[100];
        BankAccCardFilter: Code[20];
        BankAccCardInt: Integer;
        Datee: Date;
        PaymentCounter: Integer;
        PaymentAmount: Decimal;
        Counter: Integer;
        PTCounter: Integer;
        Show: Integer;
}

