report 50077 Uplatnica
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    //RDLCLayout = './Uplatnica.rdl';


    dataset
    {
        dataitem(DataItem21; "Gen. Journal Line")
        {
            column(BatchName; DataItem21."Journal Batch Name")
            {
            }
            column(PostingDate; DataItem21."Posting Date")
            {
            }
            column(AppliesToDocNo; DataItem21."Applies-to Doc. No.")
            {
            }
            column(PaymentDT; DataItem21."Payment DT")
            {
            }
            column(DocumentNo; DataItem21."Document No.")
            {
            }
            column(Amound; DataItem21.Amount)
            {
            }
            column(Description; DataItem21.Description)
            {
            }
            column(PaymentMethod; DataItem21."Payment Method")
            {
            }
            column(LineNo; DataItem21."Line No.")
            {
            }
            column(Address_Customer; DataItem21.Address_Cust)
            {
            }
            column(AccountNo; DataItem21."Account No.")
            {
            }
            column(RegistrationNo_Cust; DataItem21.RegistrationNo_Cust)
            {
            }
            column(VATRegistrationNo_Cust; DataItem21.VATRegistrationNo_Cust)
            {
            }
            column(PM; DataItem21."Payment Method Code")
            {
            }
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
            column(Country; Country)
            {
            }
            column(City; City)
            {
            }
            column(CName; ContName)
            {
            }
            column(CAddress; ContAddress)
            {
            }
            column(CCity; ContCity)
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
            column(City_Cust; City_Cust)
            {
            }


            trigger OnAfterGetRecord()
            begin

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

                //Location.SETFILTER(Code,"Location Code");
                //IF Location.FINDFIRST THEN
                //City:=Location.City;

                CountryRegion.SETFILTER(Code, CompanyInformation."Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    Country := CountryRegion.Name;


            end;
        }


        dataitem(DataItem22; "Bank Account")
        {
            column(BankName; DataItem22.Name)
            {
            }
            column(BankAccNo; DataItem22."Bank Account No.")
            {
            }
            column(Counter; Counter) { }

            trigger OnAfterGetRecord()
            begin
                if "Bank Account No." <> '' then
                    Counter := Counter + 1
                else
                    Counter := 0;

                //komentar

                //Message(FORMAT(Counter));
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
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        Country: Text[100];
        City: Text[100];
        CountryRegion: Record "Country/Region";
        Location: Record Location;
        Cont: Record Contact;
        Counter: Integer;
        ContName: Text[100];
        ContAddress: Text[100];
        ContCity: Text[100];
        emp: Record Employee;
        Cust: Record Customer;
}

