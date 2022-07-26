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
            column(User; USERID)
            {
            }
            column(Datee; Datee)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }


            trigger OnPreDataItem()
            begin
                BankAccCardFilter := GETFILTER("Bal. Account No.");

                /*IF BankAccCardFilter = 'BANK-10' THEN
                    BankAccCardInt := 1
                ELSE
                    IF BankAccCardFilter = 'BANK-11' THEN
                        BankAccCardInt := 2
                    ELSE
                        IF BankAccCardFilter = 'BANK-12' THEN
                            BankAccCardInt := 3
                        ELSE
                            IF BankAccCardFilter = 'BANK-13' THEN
                                BankAccCardInt := 4
                            ELSE
                                IF BankAccCardFilter = 'BANK-14' THEN
                                    BankAccCardInt := 5
                                ELSE
                                    IF BankAccCardFilter = 'BANK-15' THEN
                                        BankAccCardInt := 6
                                    ELSE
                                        IF BankAccCardFilter = 'BANK-16' THEN
                                            BankAccCardInt := 7
                                        ELSE
                                            IF BankAccCardFilter = 'BANK-17' THEN
                                                BankAccCardInt := 8
                                            ELSE
                                                IF BankAccCardFilter = 'BANK-18' THEN BankAccCardInt := 9*/

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
                if select=Select::"Izvještaj porto blagajne" then
                    GLEntry.SetFilter("Payment Method", '%1', 'Kartično');

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
        Country: Text[100];
        City: Text[100];
        BankAccCardFilter: Code[20];
        BankAccCardInt: Integer;
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

