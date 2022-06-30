report 50075 "Blagajnički dnevnik"
{
    //ED


    DefaultLayout = RDLC;
    RDLCLayout = './Blagajnicki dnevnik.rdl';

    dataset
    {
        dataitem(DataItem22; "G/L Entry")
        {
            DataItemTableView = WHERE("Bal. Account No." = FILTER(2050));
            RequestFilterFields = "Posting Date";

            column(PostingDate; DataItem22."Posting Date")
            {
            }
            column(JBName; DataItem22."Journal Batch Name")
            {
            }
            column(GLNo; DataItem22."Entry No.")
            {
            }
            column(DocumentNo; DataItem22."Document No.")
            {
            }
            column(Amound; DataItem22.Amount)
            {
            }
            column(Description; DataItem22.Description)
            {
            }
            column(Ext; DataItem22."External Document No.")
            {
            }
            column(Datum; Datum)
            {
            }
            column(Brdokumenta; Brdokumenta)
            {
            }
            column(Kolicina; Kolicina)
            {
            }
            column(DatumIS; DatumIS)
            {
            }
            column(BrdokumentaIS; BrdokumentaIS)
            {
            }
            column(KolicinaIS; KolicinaIS)
            {
            }
            column(PostingDatefilter; PostingDatefilter)
            {
            }
            column(Adress_CompanyInfo; CompanyInformation.Address)
            {
            }
            column(City_CompanyInfo; CompanyInformation.City)
            {
            }
            column(Phone1_CompanyInfo; CompanyInformation."Phone No.")
            {
            }
            column(Phone2_CompanyInfo; CompanyInformation."Phone No. 2")
            {
            }
            column(Fax_CompanyInfo; CompanyInformation."Fax No.")
            {
            }
            column(Email_CompanyInfo; CompanyInformation."E-Mail")
            {
            }
            column(Homepage_CompanyInfo; CompanyInformation."Home Page")
            {
            }
            column(RegistrationNo_CompanyInfo; CompanyInformation."Registration No.")
            {
            }
            column(Postcode_CompanyInfo; CompanyInformation."Post Code")
            {
            }
            column(VATRegistrationNo_CompanyInfo; CompanyInformation."VAT Registration No.")
            {
            }
            column(GiroNo_CompanyInfo; CompanyInformation."Giro No.")
            {
            }
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(PrethodniSaldo; PrethodniSaldo)
            {
            }
            column(EmmployeeName; EmmployeeName)
            {
            }


            trigger OnAfterGetRecord()
            begin
                EmmployeeName := '';
                IF "Journal Batch Name" = 'UPLATA' THEN BEGIN
                    Datum := "Posting Date";
                    Brdokumenta := "Document No.";
                    BrdokumentaIS := ''; //ED
                    Kolicina := Amount;
                END;


                IF "Journal Batch Name" = 'ISPLATA' THEN BEGIN
                    Datum := "Posting Date";
                    BrdokumentaIS := "Document No.";
                    Brdokumenta := ''; //ED
                    Kolicina := 0;
                    KolicinaIS := Amount;
                END;

                /*BALE.SETFILTER("Bank Account No.", '%1', 'BKM');
                BALE.SETFILTER("Posting Date", '<%1', "Posting Date");
                IF BALE.FIND('-') THEN
                        REPEAT

                            PrethodniSaldo += BALE."Amount (LCY)";
                        UNTIL BALE.NEXT = 0;*/




                GLEntry.SETFILTER("Bal. Account No.", '%1', '2050');
                GLEntry.SETFILTER("Posting Date", '<%1', "Posting Date");
                IF GLEntry.FIND('-') THEN
                        REPEAT
                            PrethodniSaldo += GLEntry.Amount;
                        UNTIL GLEntry.NEXT = 0;



                emp.SETFILTER("No.", '%1', "Employee No.");
                IF emp.FIND('-') THEN
                    EmmployeeName := emp."First Name" + ' ' + emp."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                PostingDatefilter := GETFILTER("Posting Date");

                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);



                //Location.SETFILTER(Code,"Location Code");
                //IF Location.FINDFIRST THEN
                //City:=Location.City;

                CountryRegion.SETFILTER(Code, CompanyInformation."Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    Country := CountryRegion.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        GLEntry: Record "G/L Entry";
        Country: Text[100];
        City: Text[100];
        Test: Integer;
        CountryRegion: Record "Country/Region";
        Location: Record Location;
        PostingDatefilter: Text[100];
        Datum: Date;
        Brdokumenta: Text[100];
        Kolicina: Decimal;
        DatumIS: Date;
        BrdokumentaIS: Text[100];
        KolicinaIS: Decimal;
        BankAccount: Record "Bank Account";
        PrethodniSaldo: Decimal;
        emp: Record Employee;
        EmmployeeName: Text[150];
        BALE: Record "Bank Account Ledger Entry";


}

