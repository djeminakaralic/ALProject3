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
            column(Adress_CompanyInfo; CompanyInformation.Address)
            {
            }
            column(City_CompanyInfo; CompanyInformation.City)
            {
            }
            column(Name; CompanyInformation.Name)
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
            column(User; USERID)
            {
            }
            column(IndustrialClassification_CompanyInfo; CompanyInformation."Industrial Classification")
            {
            }
            column(MBS; CompanyInformation.MBS)
            {
            }
            column(MunicipalityName; CompanyInformation."Municipality Name")
            {
            }
            column(Registration_CompanyInfo; CompanyInformation."Registration Text")
            {
            }
            column(Tax_CompanyInfo; CompanyInformation."Tax No.")
            {
            }
            column(Datee; Datee)
            {
            }

            trigger OnAfterGetRecord()
            begin


                //MESSAGE(Format(PostingDatefilter));
                /*Cont.SETFILTER("No.",'%1',"Contact Link");
                
                IF Cont.FIND('-') THEN BEGIN
                
                ContName:=Cont.Name;
                ContAddress:=Cont.Address;
                ContCity:=Cont."Post Code"+', '+Cont.City;
                END;     */

                /*emp.SETFILTER("No.", '%1', emp."Employee No."); //ovdje je stajalo samo employee no

                IF emp.FIND('-') THEN BEGIN

                    ContName := emp."First Name" + emp."Last Name";
                    ContAddress := emp.Address;
                    ContCity := emp."Post Code" + ', ' + emp.City;
                END;*/


            end;

            trigger OnPreDataItem()
            begin

                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

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
                
                //za svaku vrstu uplate koju uzimam u PT code polje stavljam filtere
                //naziv serije naloga knjižnja, datum, vrsta uplate, uplata kao vrsta dokumenta

                //GLEntry.SetFilter("Journal Batch Name", '%1', );
                GLEntry.SetFilter("Posting Date", '%1', Datee);
                GLEntry.SetFilter("Payment Type Code", '%1', DataItem22.Code);
                 
                PaymentCounter := GLEntry.Count;

                PaymentAmount := 0;
                IF GLEntry.FindFirst() then
                    repeat
                        PaymentAmount += ABS(GLEntry.Amount);
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
        Country: Text[100];
        City: Text[100];
        PostingDatefilter: Code[10];
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

