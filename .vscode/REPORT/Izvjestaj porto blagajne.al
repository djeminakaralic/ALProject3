report 50085 "Izvještaj porto blagajne"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Izvjestaj porto blagajne.rdl';


    dataset
    {
        dataitem(DataItem21; "G/L Entry")
        {
            trigger OnPreDataItem()
            begin
                BankAccCardFilter := GETFILTER("Bal. Account No.");
            end;
        }

        dataitem(DataItem22; "Payment Type")
        {
            column(PTCode; DataItem22.Code)
            {
            }
            column(PaymentCounter; PaymentCounter)
            {
            }
            column(PaymentAmount; PaymentAmount)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(Datee; Datee)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(User; USERID)
            {
            }
            column(Select; Select)
            {
            }
            column(PTCounter;PTCounter)
            {
            }

            trigger OnAfterGetRecord()
            begin

                //za svaku vrstu uplate koju uzimam u PT code polje stavljam filtere
                //naziv serije naloga knjižnja, datum, vrsta uplate, uplata kao vrsta dokumenta

                GLEntry.SetFilter("Bal. Account No.", '%1', BankAccCardFilter);
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Payment Type Code", '%1', DataItem22.Code);
                if select = Select::"POS terminali dnevni izvještaj" then begin
                    GLEntry.SetFilter("Payment Method", '%1', 'Kartično');
                    ReportTitle := 'DNEVNI IZVJEŠTAJ SA BLAGAJNE';
                end else
                    ReportTitle := 'IZVJEŠTAJ PORTO BLAGAJNE Br. ';

                PaymentCounter := GLEntry.Count;

                PaymentAmount := 0;

                IF GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += ABS(GLEntry.Amount);
                    until GLEntry.Next() = 0;

                Counter += 1;

            end;

            trigger OnPreDataItem()
            begin
                PTCounter := DataItem22.Count;
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
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Select; Select)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ' ,Izvještaj porto blagajne,POS terminali dnevni izvještaj';
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
        Select: Option ,"Izvještaj porto blagajne","POS terminali dnevni izvještaj";
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
}

