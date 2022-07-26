report 50194 "POS dnevni izvjestaj"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './POS dnevni izvjestaj sa blagajne.rdl';

    dataset
    {
        dataitem(DataItem21; "G/L Entry")
        {
            column(User; USERID)
            {
            }
            column(Datee; Datee)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(BankAddress; BankAddress)
            {
            }

            trigger OnPreDataItem()
            begin
                BankAccCardFilter := GETFILTER("Bal. Account No.");

                BankAccount.SetFilter("Bank Account No.", '%1', BankAccCardFilter);
                if BankAccount.FindFirst() then
                    BankAddress := BankAccount.Address;

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

            trigger OnAfterGetRecord()
            begin
                /*if GLEntry.FindFirst() then begin
                    //PostingDatefilter := GETFILTER(GLEntry."Bal. Account No.");
                    Message(Format(GLEntry."Bal. Account No."));
                end;*/

                //za svaku vrstu uplate koju uzimam u PT code polje stavljam filtere
                //naziv serije naloga knjižnja, datum, vrsta uplate, uplata kao vrsta dokumenta

                GLEntry.SetFilter("Bal. Account No.", '%1', BankAccCardFilter);
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Payment Type Code", '%1', DataItem22.Code);

                PaymentCounter := GLEntry.Count;

                PaymentAmount := 0;

                IF GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += ABS(GLEntry.Amount);
                    until GLEntry.Next() = 0;

            end;

            trigger OnPreDataItem()
            begin


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
        Country: Text[100];
        City: Text[100];
        BankAccCardFilter: Code[20];
        BankAccCardInt: Integer;
        Datee: Date;
        PaymentCounter: Integer;
        PaymentAmount: Decimal;
        BankAddress: Text[100];
}

