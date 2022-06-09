report 50077 Uplatnica
{
    DefaultLayout = RDLC;
    RDLCLayout = './Uplatnica.rdlc';


    dataset
    {
        dataitem(DataItem21; "Gen. Journal Line")
        {
            DataItemTableView = WHERE("Account Type" = FILTER('Customer'), Description = FILTER('Elmira Dedović'));
            //DataItemTableView = WHERE("Contribution Category Code" = FILTER('AUTH.CONT'));
           /*DataItemTableView = WHERE(Status = CONST(Active),
                                          "Potential Employee" = CONST(false));*/
            

                                

            column(BatchName; GJLine."Journal Batch Name")
            {
            }
            column(PostingDate; GJLine."Posting Date")
            {
            }
            column(DocumentNo; GJLine."Document No.")
            {
            }
            
            column(Amound; GJLine.Amount)
            {
            }
            column(Description; GJLine.Description)
            {
            }
            column(LineNo; GJLine."Line No.")
            {
            }
            column(PM; GJLine."Payment Method Code")
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



            trigger OnAfterGetRecord()
            begin
                /*Cont.SETFILTER("No.",'%1',"Contact Link");
                
                IF Cont.FIND('-') THEN BEGIN
                
                ContName:=Cont.Name;
                ContAddress:=Cont.Address;
                ContCity:=Cont."Post Code"+', '+Cont.City;
                END;     */

                emp.SETFILTER("No.", '%1', emp."Employee No."); //ovdje je stajalo samo employee no

                IF emp.FIND('-') THEN BEGIN

                    ContName := emp."First Name" + emp."Last Name";
                    ContAddress := emp.Address;
                    ContCity := emp."Post Code" + ', ' + emp.City;
                END;

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
        Country: Text[100];
        City: Text[100];
        CountryRegion: Record "Country/Region";
        Location: Record Location;
        Cont: Record Contact;
        ContName: Text[100];
        ContAddress: Text[100];
        ContCity: Text[100];
        emp: Record Employee;
}

