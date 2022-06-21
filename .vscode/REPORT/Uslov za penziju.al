report 50112 "Uslov za penziju"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Uslov za penziju.rdlc';

    dataset
    {
        dataitem(DataItem17; Employee)
        {
            RequestFilterFields = "No.", "Department Code", "First Name", "Last Name", "Retirement Condition", "Retirement Date", "Department Name", Pager;
            //RequestFilterFields = "No.", "Sifra UOJ", "First Name", "Last Name", "Retirement Condition", "Retirement Date", "Level of Graduation", "Org. jed PU", Pager;
            column(Pager_Employee; Pager)
            {
            }
            column(RetirementYear; RetirementYear)
            {
            }
            column(EducationLevel_Employee; "Education Level")
            {
            }
            column(No_Employee; "No.")
            {
            }
            column(FirstName_Employee; "First Name")
            {
            }
            column(LastName_Employee; "Last Name")
            {
            }
            column(OrgjedPU_Employee; "Department Code")
            {
            }
            column(Year1_Employee; Year1)
            {
            }
            column(NazivOrgjedPU_Employee; "Department Name")
            {
            }
            column(Year2_Employee; "Year 2")
            {
            }
            column(Year3_Employee; Year3)
            {
            }
            column(Godina; Godina)
            {
            }
            column(Godina2; Godina2)
            {
            }
            column(Godina3; Godina3)
            {
            }
            column(Mjesec; Mjesec)
            {
            }
            column(Uslov; Uslov)
            {
            }
            column(DatumUslova; DatumUslova)
            {
            }
            column(RetirementCondition_Employee; "Retirement Condition")
            {
            }
            column(RetirementDate_Employee; "Retirement Date")
            {
            }
            column(brojac; brojac)
            {
            }
            column(Godina4; Godina4)
            {
            }

            trigger OnAfterGetRecord()
            begin
                brojac := brojac + 1;
                EmployeeRec.CALCFIELDS("Department code", "Department Name", "Education Level");
                //EmployeeRec.CALCFIELDS("Naziv Org. jed PU", "Org. jed PU", "Tip RM", "Sifra UOJ", "Employee Type");
                /*
                IF "Retirement Date" <> 0D THEN
                RetirementYear:=DATE2DMY("Retirement Date",3);
                
                IF Status=0 THEN BEGIN
                IF "Retirement Date" <> 0D THEN BEGIN
                RetirementYear:=DATE2DMY("Retirement Date",3);
                END;
                END
                ELSE IF Status=2 THEN BEGIN
                    IF "Grounds for Term. Code"='PEN' THEN BEGIN
                      IF "Termination Date" = 0D THEN
                        RetirementYear:=DATE2DMY("Termination Date",3);
                        Year1:=TRUE;
                     END;
                END;  */

            end;

            trigger OnPreDataItem()
            begin
                Godina1 := DATE2DMY(TODAY, 3);
                Godina2 := DATE2DMY(TODAY, 3) + 1;
                Godina3 := DATE2DMY(TODAY, 3) + 2;
                Godina4 := DATE2DMY(TODAY, 3) + 3;

                SETFILTER(Status, '%1', 0);
                FirstDate := DMY2DATE(1, Mjesec, Godina);
                LastDate := CALCDATE('+1<M>-1<D>', FirstDate);
                SETRANGE("Retirement Date", FirstDate, LastDate);

                IF (StarPenz = TRUE) //AND StazPenz=FALSE)
                 THEN
                    SETFILTER("Retirement Condition", '2')
                ELSE
                    IF (StazPenz = TRUE) //AND StarPenz=FALSE)
                THEN
                        SETFILTER("Retirement Condition", '1');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Mjesec; Mjesec)
                {
                    Caption = 'Mjesec';
                }
                field(Godina; Godina)
                {
                    Caption = 'Godina';
                }
                field("Na osn. godina starosti"; StarPenz)
                {
                    Caption = 'Na osn. godina starosti';
                }
                field("Na osn. staža"; StazPenz)
                {
                    Caption = 'Na osn. staža';
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

    trigger OnInitReport()
    begin
        Mjesec := DATE2DMY(TODAY, 2);
        Godina := DATE2DMY(TODAY, 3);
    end;

    trigger OnPreReport()
    begin
        R_WorkExperience.RUN;
        R_BroughtExperience.RUN;
        REPORT.RUN(50222);
        brojac := 0;
    end;

    var
        Godina1: Integer;
        Godina2: Integer;
        Godina3: Integer;
        Starost: Integer;
        datum: Date;
        mjesecT: Integer;
        mjesecR: Integer;
        Uslov: Text;
        DatumUslova: Date;
        EmployeeRec: Record Employee;
        RetirementYear: Integer;
        Mjesec: Integer;
        Godina: Integer;
        StarPenz: Boolean;
        StazPenz: Boolean;
        FirstDate: Date;
        LastDate: Date;
        brojac: Integer;
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        Godina4: Integer;
}

