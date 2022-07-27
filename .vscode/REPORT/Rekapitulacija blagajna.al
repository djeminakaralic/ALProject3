report 50186 "Rekapitulacija uplata/isplata"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Rekapitulacija blagajna.rdl';


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
            column(UplataIznos; UplataIznos)
            {
            }
            column(IsplataIznos; IsplataIznos)
            {
            }
            column(Datee; Datee)
            {
            }

            trigger OnAfterGetRecord()
            begin
                UplataIznos:=0;
                IsplataIznos:=0;

                GLEntry.SetFilter("Bal. Account No.", '%1', DataItem22."No.");
                GLEntry.SetFilter("Posting Date", '%1', Datee);

                //PAZITI DA OVDJE ZAOBIĐEM POLOG PAZARA KAO ISPLATU
                if GLEntry.FindFirst() then
                    repeat
                        UplataIznos += GLEntry."Credit Amount";
                        IsplataIznos += GLEntry."Debit Amount";
                    until GLEntry.Next() = 0;

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
        UplataIznos: Decimal;
        IsplataIznos: Decimal;
}

