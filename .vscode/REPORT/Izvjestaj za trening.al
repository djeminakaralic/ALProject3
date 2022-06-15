report 50054 "Izvjestaj za_trening"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Izvjestaj za trening.rdl';

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
            column(ProofOfEducation_EmployeeQualification; DataItem1."Evidence of certification")
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
            /*column(Picture; CompInfo.Picture)
            {
                IncludeCaption = true;
            }*/
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
            column(Picture; CompInfo.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Employee First Name", "Employee Last Name");

                //ZA DATUM DA ISPISE IME MJESECA I GODINU
                Datum := FORMAT("To Date", 0, '<Month Text> <year4>');

                /*IF "Proof Of Education" = 0 THEN
                    VarDokazEdukacije := ' '
                ELSE
                    IF "Proof Of Education" = 1 THEN
                        VarDokazEdukacije := 'Certifikat'
                    ELSE
                        IF "Proof Of Education" = 2 THEN
                            VarDokazEdukacije := 'Atest'
                        ELSE
                            IF "Proof Of Education" = 3 THEN
                                VarDokazEdukacije := 'Uvjerenje'
                            ELSE
                                VarDokazEdukacije := 'Potvrda';*/

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
                CALCFIELDS(Status);

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

