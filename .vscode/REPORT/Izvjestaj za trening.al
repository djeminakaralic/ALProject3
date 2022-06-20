report 50054 "Izvjestaj za trening"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Izvjestaj za trening.rdlc';

    dataset
    {
        dataitem(DataItem1; "Employee Qualification")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "From Date";
            column(EmployeeFirstName_EmployeeQualification; "Employee First Name")
            {
            }
            column(EmployeeLastName_EmployeeQualification; "Employee Last Name")
            {
            }
            column(InstitutionCompany_EmployeeQualification; "Institution/Company")
            {
            }
            column(ToDate_EmployeeQualification; "To Date")
            {
            }
            column(Datum; Datum)
            {
            }
            column(Status_EmployeeQualification; Status)
            {
            }
            column(ProofOfEducation_EmployeeQualification; "Evidence of certification")
            {
            }
            column(ExpirationDate_EmployeeQualification; FORMAT("Expiration Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(Type_EmployeeQualification; Type)
            {
            }
            column(Department_Code; EmployeeContractLedger."Department Code")
            {
                IncludeCaption = true;
            }
            column(Picture; CompInfo.Picture)
            {
                IncludeCaption = true;
            }
            column(Adress; CompInfo.Address)
            {
                IncludeCaption = true;
            }
            column(City; CompInfo.City)
            {
                IncludeCaption = true;
            }
            column(PhoneNo; CompInfo."Phone No.")
            {
                IncludeCaption = true;
            }
            column(Name; CompInfo.Name)
            {
            }
            column(IDBr; CompInfo."Registration No.")
            {
            }
            column(QualificationCode_EmployeeQualification; "Qualification Code")
            {
            }
            column(Description_EmployeeQualification; Description)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DataItem1.CALCFIELDS("Employee First Name", "Employee Last Name");

                //ZA DATUM DA ISPISE IME MJESECA I GODINU
                Datum := FORMAT("To Date", 0, '<Month Text> <year4>');

                IF "Evidence of certification" = "Evidence of certification"::Empty THEN
                    VarDokazEdukacije := ' '
                ELSE
                    IF "Evidence of certification" = "Evidence of certification"::Certifikat THEN
                        VarDokazEdukacije := 'Certifikat'
                    ELSE
                        IF "Evidence of certification" = "Evidence of certification"::Atest THEN
                            VarDokazEdukacije := 'Atest'
                        ELSE
                            IF "Evidence of certification" = "Evidence of certification"::Uvjerenje THEN
                                VarDokazEdukacije := 'Uvjerenje'
                            ELSE
                                VarDokazEdukacije := 'Potvrda';

                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);

                //EmployeeContractLedger.GET;
                //ZA OJ
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", '%1', "Employee No.");
                EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                    DepartmentCode := EmployeeContractLedger."Department Code";
                END;


                /*InputDate:="Employee Qualification"."To Date";
                Month:=DATE2DMY(InputDate,2);
                Year:=DATE2DMY(InputDate,3);*/


                //var :="Employee Qualification"."To Date";
                //Mjesec := DATE2DMY(var,2);
                //Godina := DATE2DMY(var,2);
                //MESSAGE(Text000,Mjesec,Godina);

                //IF("Employee Qualification"."To Date") THEN
                //MESSAGE("Januar");
                //ELSE
                //MESSAGE("Decembar");

                //SifraKvalifikacije:='';

                /*IF SifraKvalifikacije.FINDFIRST THEN
                  VarSifra:=SifraKvalifikacije;
                ELSE
                  SifraKvalifikacije.DELETE;*/

                /*IF "Employee Qualification"."Qualification Code".FINDFIRST THEN
                  SifraKvalifikacije:="Employee Qualification"."Qualification Code";
                ELSE
                  SifraKvalifikacije:='';*/


                /*Sales.SETRANGE("Posting Description", 'Test'); Sales.SETFILTER(Amount, '=%1', 0); IF Sales.FIND('-') THEN Sales.DELETEALL;*/


            end;

            trigger OnPreDataItem()
            begin
                SETFILTER(Status, '%1', Status::Active);
                DataItem1.CALCFIELDS(Status);

                SETFILTER("Qualification Code", '<>%1', '');


                //SETFILTER(Type,'%1',"Employee Qualification"."Qualification Code");
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
        RptTitle = 'LISTA INDIKATORA ZA EDUKACIJE I TRENINGE';
    }

    var
        InputDate: Date;
        Month: Integer;
        Date: Integer;
        Year: Integer;
        Datum: Text;
        VarDokazEdukacije: Text;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        DepartmentCode: Code[10];
        CompInfo: Record "Company Information";
        SifraKvalifikacije: Record "Employee Qualification";
        VarSifra: Record "Employee Qualification";
}

