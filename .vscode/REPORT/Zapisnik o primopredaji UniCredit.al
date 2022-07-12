report 50097 "Zapisnik o primopredaji"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Zapisnik o primopredaji UniCredit.rdl';

    dataset
    {
        dataitem(DataItem21; "G/L Entry")
        {
            /*column(BatchName; DataItem21."Journal Batch Name  "Gen. Journal Line"
            {
            }
            column(PostingDate; DataItem21."Posting Date")
            {
            }
            column(Address_Customer; DataItem21.Address_Cust)
            {
            }
            column(AccountNo; DataItem21."Account No.")
            {
            }
            column(PM; DataItem21."Payment Method Code") 
            {
            }*/

            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(User; USERID)
            {
            }
            column(Datee; Datee)
            {
            }
            

            trigger OnAfterGetRecord()
            begin

            end;

            trigger OnPreDataItem()
            begin
               
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

            end;
        }

        /*dataitem(DataItem22; )
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
        }*/
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Date")
                {
                    Caption = 'Datum zapisnika';
                    field(Datee; Datee)
                    {
                        Caption = 'Datum zapisnika: ';
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
        ApoeniEnum: Enum "Apoeni Enum";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        GLEntry: Record "G/L Entry";
        Country: Text[100];
        City: Text[100];
        CountryRegion: Record "Country/Region";
        Location: Record Location;
        Cont: Record Contact;
        ContName: Text[100];
        ContAddress: Text[100];
        ContCity: Text[100];
        emp: Record Employee;
        Cust: Record Customer;
        Datee: Date;
        PaymentCounter: Integer;
        PaymentAmount: Decimal;
}

