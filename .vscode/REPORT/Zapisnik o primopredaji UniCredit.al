report 50097 "Zapisnik o primopredaji"
{
    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Zapisnik o primopredaji UniCredit.rdl';

    dataset
    {
        dataitem(DataItem20; Apoeni)
        {
            trigger OnPreDataItem()
            begin
                BalAccNoFilter := GETFILTER("Bal. Account No.");
            end;
        }
        dataitem(DataItem21; "G/L Entry")
        {
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(User; USERID)
            {
            }
            column(Datee; Datee)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                Datee := System.Today;
            end;
        }
        dataitem(PaymentType; "Payment Type")
        {
            UseTemporary = true;

            column(CCode; PaymentType.Code)
            {
            }
            column(Counter; Counter)
            {

            }
            column(Counter2; Counter2)
            {
            }
            column(AmountRecord; AmountRecord)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Counter += 1; //ovaj counter broji koji apoen je po redu da bih mogla filtrirati tabelu apoeni

                /*if PaymentType.Code = FORMAT(200) then
                    FilterInt := 1
                else
                    if PaymentType.Code = FORMAT(100) then
                        FilterInt := 2
                    else
                        if PaymentType.Code = FORMAT(50) then
                            FilterInt := 3
                        else
                            if PaymentType.Code = FORMAT(20) then
                                FilterInt := 4
                            else
                                if PaymentType.Code = FORMAT(10) then
                                    FilterInt := 5
                                else
                                    if PaymentType.Code = FORMAT(5) then
                                        FilterInt := 6
                                    else
                                        if PaymentType.Code = FORMAT(2) then
                                            FilterInt := 7
                                        else
                                            if PaymentType.Code = FORMAT(1) then
                                                FilterInt := 8
                                            else
                                                if PaymentType.Code = FORMAT('0.5') then
                                                    FilterInt := 9
                                                else
                                                    if PaymentType.Code = FORMAT('0.2') then
                                                        FilterInt := 10
                                                    else
                                                        if PaymentType.Code = FORMAT('0.1') then
                                                            FilterInt := 11
                                                        else
                                                            if PaymentType.Code = FORMAT('0.05') then FilterInt := 12;*/



                DataItem20.Reset();
                DataItem20.SetFilter(Apoeni, '%1', Counter);
                DataItem20.SetFilter("Bal. Account No.", '%1', BalAccNoFilter);
                DataItem20.SetFilter("Posting Date", '%1', Datee);

                if DataItem20.FindFirst() then begin
                    Counter2 := DataItem20.Quantity;
                    AmountRecord := DataItem20.Amount;
                    TotalAmount += AmountRecord;
                end
                else begin
                    Counter2 := 0;
                    AmountRecord := 0;
                end;

            end;

            trigger OnPreDataItem()
            begin

                Counter := 0;
                Counter2 := 0;
                TotalAmount := 0;

                PaymentType.DeleteAll();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"200");
                PaymentType."Entry No." := 1;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"100");
                PaymentType."Entry No." := 2;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"50");
                PaymentType."Entry No." := 3;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"20");
                PaymentType."Entry No." := 4;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"10");
                PaymentType."Entry No." := 5;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"5");
                PaymentType."Entry No." := 6;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"2");
                PaymentType."Entry No." := 7;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"1");
                PaymentType."Entry No." := 8;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"0.50");
                PaymentType."Entry No." := 9;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"0.20");
                PaymentType."Entry No." := 10;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"0.10");
                PaymentType."Entry No." := 11;
                PaymentType.Insert();

                PaymentType.Init();
                PaymentType.Code := Format(ApoeniEnum::"0.05");
                PaymentType."Entry No." := 12;
                PaymentType.Insert();

                PaymentType.SetCurrentKey("Entry No.");
                PaymentType.Ascending;

                Datee := System.Today;

            end;

        }

    }

    requestpage
    {
        layout
        {
            /*area(content)
            {
                group("Date")
                {
                    Caption = 'Datum zapisnika';
                    field(Datee; Datee)
                    {
                        Caption = 'Datum zapisnika: ';
                    }
                }
            }*/
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
        Counter: Integer;
        Counter2: Integer;
        Datee: Date;
        PaymentCounter: Integer;
        TotalAmount: Decimal;
        FilterInt: Integer;
        AmountRecord: Decimal;
        BalAccNoFilter: Code[20];
}

