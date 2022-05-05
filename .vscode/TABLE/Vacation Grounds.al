table 50162 "Vacation Grounds"
{
    Caption = 'Vacation Grounds';

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                t_Employee.SETFILTER("No.", '%1', "Employee No.");
                IF t_Employee.FIND('-') THEN BEGIN
                    //"Work experience":=employee."Years of Experience";
                    "First Name" := t_Employee."First Name";
                    "Last Name" := t_Employee."Last Name";
                    "Work experience" := t_Employee."Years of Experience";
                END;
                CurrYear := DATE2DMY(TODAY, 3);
                VacationSetup.GET;
                "Legal Grounds" := VacationSetup."Base Days";
                //"End Date of Year" := DMY2DATE(1, 12, CurrYear);
                //LastDateOfMonth:=CALCDATE('-1D', CALCDATE('+1M',"End Date of Year"));
                //MESSAGE(FORMAT(LastDateOfMonth));
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
                EVALUATE(Order, "Employee No.");


                EmployeeRec.RESET;
                EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                IF EmployeeRec."Returned to Company" = FALSE THEN BEGIN
                    UsedDaysThisYear := 0;
                    Year2 := DATE2DMY(TODAY, 3);
                    WB.RESET;
                    PlanGO.RESET;
                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL.SETFILTER("Reason for Change", '%1', 1);
                    ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                    //ECL.SETFILTER(Active,'%1',TRUE);
                    IF ECL.FINDFIRST THEN BEGIN
                        WB.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        IF WB.FIND('+') THEN BEGIN
                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(TODAY, 3) THEN
                                "Legal Grounds" := WB.Months - (12 - DATE2DMY(WB."Starting Date", 2))
                            ELSE
                                "Legal Grounds" := WB.Months;
                            Year := Year2;

                            Absence.RESET;
                            Absence.SETFILTER("Employee No.", '%1', "Employee No.");
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDaysThisYear := Absence.COUNT;


                            // PlanGO.CALCFIELDS("Used Days");
                            // PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-PlanGO."Used Days";
                            "Legal Grounds" := "Legal Grounds" - UsedDaysThisYear;
                            Year := Year2;

                        END;
                    END
                    ELSE BEGIN
                        EmployeeRec.RESET;
                        EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                        IF EmployeeRec.FINDFIRST THEN BEGIN
                            VacationSetup.GET;
                            "Legal Grounds" := VacationSetup."Base Days";
                            Year := Year2;
                            Experience.SETFILTER(LowerLimit, '<=%1', EmployeeRec."Current Years Total");
                            Experience.SETFILTER(UpperLimit, '>=%1', EmployeeRec."Current Years Total");
                            IF Experience.FINDFIRST THEN BEGIN
                                "Days based on Work experience" := Experience.Vacation;
                                Year := Year2;
                            END
                            ELSE BEGIN
                                "Days based on Work experience" := 0;
                                Year := Year2;

                            END;



                            // po stepenu invalidnosti

                            IF ((EmployeeRec."Disabled Person" = TRUE) OR (EmployeeRec."Chronic Disease" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No.", '%1', '1');
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Days based on Disability" := SocialStatus.Points;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Days based on Disability" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Days based on Disability" := 0;
                                Year := Year2;
                            END;




                            //roditelj djece sa posebnim potrebama
                            IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No.", '%1', '2');
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Based on Disabled Child" := SocialStatus.Points;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Based on Disabled Child" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Based on Disabled Child" := 0;
                                Year := Year2;
                            END;
                        END;



                    END;


                    UsedDaysThisYear := 0;
                    WB.RESET;
                    PlanGO.RESET;

                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL.SETFILTER("Reason for Change", '%1', 1);
                    ECL.SETFILTER("Way of Employment", '%1|%2|%3', 1, 2, 0);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-6M', TODAY), TODAY);
                    //ECL.SETFILTER(Active,'%1',TRUE);
                    ECL.SETFILTER("First Time Employed", '%1', TRUE);
                    IF ECL.FINDFIRST THEN BEGIN
                        WB.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        IF WB.FIND('+') THEN BEGIN

                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(TODAY, 3) THEN
                                "Legal Grounds" := WB.Months - (12 - DATE2DMY(WB."Starting Date", 2))
                            ELSE
                                "Legal Grounds" := WB.Months;
                            Year := Year2;

                            Absence.RESET;
                            Absence.SETFILTER("Employee No.", '%1', "Employee No.");
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDaysThisYear := Absence.COUNT;


                            // PlanGO.CALCFIELDS("Used Days");
                            // PlanGO."Legal Grounds":=PlanGO."Legal Grounds"-PlanGO."Used Days";
                            "Legal Grounds" := "Legal Grounds" - UsedDaysThisYear;
                            Year := Year2;
                        END;
                    END
                    ELSE BEGIN
                        VacationSetup.GET;
                        "Legal Grounds" := VacationSetup."Base Days";
                        EmployeeRec.RESET;
                        EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                        IF EmployeeRec.FINDFIRST THEN BEGIN
                            Experience.SETFILTER(LowerLimit, '<=%1', EmployeeRec."Current Years Total");
                            Experience.SETFILTER(UpperLimit, '>=%1', EmployeeRec."Current Years Total");
                            IF Experience.FINDFIRST THEN BEGIN
                                "Days based on Work experience" := Experience.Vacation;
                                Year := Year2;
                            END
                            ELSE BEGIN
                                "Days based on Work experience" := 0;
                                Year := Year2;
                            END;



                            // po stepenu invalidnosti
                            IF ((EmployeeRec."Disabled Person" = TRUE) OR (EmployeeRec."Chronic Disease" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No.", '%1', '1');
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Days based on Disability" := SocialStatus.Points;
                                    Year := Year2;

                                END
                                ELSE BEGIN
                                    "Days based on Disability" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Days based on Disability" := 0;
                                Year := Year2;
                            END;




                            //roditelj djece sa posebnim potrebama
                            IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                SocialStatus.SETFILTER("No.", '%1', '2');
                                IF SocialStatus.FINDFIRST THEN BEGIN
                                    "Based on Disabled Child" := SocialStatus.Points;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Based on Disabled Child" := 0;
                                    Year := Year2;
                                END;
                            END
                            ELSE BEGIN
                                "Based on Disabled Child" := 0;
                                Year := Year2;
                            END;

                        END;
                        Year := Year2;
                    END;
                END;

                EmployeeRec.RESET;
                EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                IF EmployeeRec."Returned to Company" = TRUE THEN BEGIN
                    WB.RESET;
                    PlanGO.RESET;
                    ECL.RESET;
                    Absence.RESET;
                    UsedDays := 0;
                    ECL.SETFILTER("Employee No.", '%1', "Employee No.");
                    ECL.SETFILTER("Reason for Change", '%1', 1);
                    ECL.SETFILTER("Way of Employment", '%1|%2', 1, 2);
                    ECL.SETFILTER("Starting Date", '%1..%2', CALCDATE('-14D', TODAY), TODAY);
                    IF ECL.FINDFIRST THEN BEGIN

                        WB.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                        WB.SETFILTER("Current Company", '%1', TRUE);
                        IF WB.FIND('+') THEN BEGIN

                            IF DATE2DMY(WB."Starting Date", 3) <> DATE2DMY(TODAY, 3) THEN
                                "Legal Grounds" := WB.Months - (12 - DATE2DMY(WB."Starting Date", 2))
                            ELSE
                                "Legal Grounds" := WB.Months;
                            Year := Year2;

                            Absence.SETFILTER("Employee No.", '%1', ECL."Employee No.");
                            //Absence.SETFILTER("Vacation from Year",'<>%1',0);
                            Absence.SETFILTER("Vacation from Year", '%1', Year2);
                            //Absence.SETFILTER("From Date",'%1..%2',CALCDATE('-14D',TODAY),TODAY);
                            Absence.SETFILTER("Cause of Absence Code Corr.", '%1', '@*GOD*');
                            IF Absence.FINDSET THEN
                                UsedDays := Absence.COUNT;
                            "Legal Grounds" := "Legal Grounds" - UsedDays;
                            Year := Year2;

                        END
                        ELSE BEGIN
                            VacationSetup.GET;
                            "Legal Grounds" := VacationSetup."Base Days";
                            EmployeeRec.RESET;
                            EmployeeRec.SETFILTER("No.", '%1', "Employee No.");
                            IF EmployeeRec.FINDFIRST THEN BEGIN
                                Experience.SETFILTER(LowerLimit, '<=%1', EmployeeRec."Current Years Total");
                                Experience.SETFILTER(UpperLimit, '>=%1', EmployeeRec."Current Years Total");
                                IF Experience.FINDFIRST THEN BEGIN
                                    "Days based on Work experience" := Experience.Vacation;
                                    Year := Year2;
                                END
                                ELSE BEGIN
                                    "Days based on Work experience" := 0;
                                    Year := Year2;
                                END;



                                // po stepenu invalidnosti
                                IF ((EmployeeRec."Disabled Person" = TRUE) OR (EmployeeRec."Chronic Disease" = TRUE)) THEN BEGIN
                                    SocialStatus.SETFILTER("No.", '%1', '1');
                                    IF SocialStatus.FINDFIRST THEN BEGIN
                                        "Days based on Disability" := SocialStatus.Points;
                                        Year := Year2;

                                    END
                                    ELSE BEGIN
                                        "Days based on Disability" := 0;
                                        Year := Year2;
                                    END;
                                END
                                ELSE BEGIN
                                    "Days based on Disability" := 0;
                                    Year := Year2;
                                END;




                                //roditelj djece sa posebnim potrebama
                                IF ((EmployeeRec."Disabled Child" = TRUE)) THEN BEGIN
                                    SocialStatus.SETFILTER("No.", '%1', '2');
                                    IF SocialStatus.FINDFIRST THEN BEGIN
                                        "Based on Disabled Child" := SocialStatus.Points;
                                        Year := Year2;
                                    END
                                    ELSE BEGIN
                                        "Based on Disabled Child" := 0;
                                        Year := Year2;
                                    END;
                                END
                                ELSE BEGIN
                                    "Based on Disabled Child" := 0;
                                    Year := Year2;
                                END;

                            END;







                        END;
                        Year := Year2;
                    END;
                END;

            end;
        }
        field(2; "Work experience"; Integer)
        {
            Caption = 'Work experience';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
            end;
        }
        field(3; "Legal Grounds"; Integer)
        {
            Caption = 'Legal Grounds';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";

                EVALUATE(Order, "Employee No.");
            end;
        }
        field(4; "Days based on Work experience"; Integer)
        {
            Caption = 'Days based on Work experience';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
            end;
        }
        field(8; "Days based on Disability"; Integer)
        {
            Caption = 'Days based on Disability';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
            end;
        }
        field(9; "Total days"; Integer)
        {
            Caption = 'Total Days';
            Editable = true;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = "U cjelini","U dva dijela";
        }
        field(11; Year; Integer)
        {
            Caption = 'Year';
        }
        field(12; "First Name"; Text[50])
        {
            Caption = 'Ime';
        }
        field(13; "Last Name"; Text[50])
        {
            Caption = 'Prezime';
        }
        field(14; "Starting Date of I part"; Date)
        {
            Caption = 'Starting Date of I part';
        }
        field(15; "Ending Date of I part"; Date)
        {
            Caption = 'Ending Date of I part';

            trigger OnValidate()
            begin
                /*  WPConnSetup.FINDFIRST();


                  CREATE(conn, TRUE, TRUE);

                    conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                              + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                    CREATE(comm, TRUE, TRUE);

                    lvarActiveConnection := conn;
                    comm.ActiveConnection := lvarActiveConnection;

                    comm.CommandText := 'dbo.Vacation_Requests_Insert';
                    comm.CommandType := 4;
                    comm.CommandTimeout := 0;


                    param := comm.CreateParameter('@emp', 200, 1, 30, "Employee No.");
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@CreationDate', 7, 1, 0, TODAY);
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@h_from', 7, 1, 0, "Starting Date of I part");
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@h_to', 7, 1, 0, "Ending Date of I part");
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@status', 3, 1, 0, 1);
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@type', 200, 1, 30, 'DEC');
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@year', 3, 1, 0, Year);
                    comm.Parameters.Append(param);
                    param := comm.CreateParameter('@duration', 3, 1, 0, "Ending Date of I part" - "Starting Date of I part");
                    comm.Parameters.Append(param);

                    comm.Execute;
                    conn.Close;
                    CLEAR(conn);
                    CLEAR(comm);



                    /*

                    WPConnSetup.FINDFIRST();
                    CREATE(conn, TRUE, TRUE);

                    conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                              +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

                    CREATE(comm,TRUE, TRUE);

                    lvarActiveConnection := conn;
                    comm.ActiveConnection := lvarActiveConnection;

                    comm.CommandText := 'dbo.Vacation_Requests_Update';
                    comm.CommandType := 4;
                    comm.CommandTimeout := 0;


                    param:=comm.CreateParameter('@emp', 200, 1, 30, "Employee No.");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@CreationDate', 7, 1, 0, TODAY);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@h_from', 7, 1, 0, "Starting Date of I part");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@h_to', 7, 1, 0, "Ending Date of I part");
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@status', 3, 1, 0, 1);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@type', 200, 1, 30, 'DEC');
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@year',3, 1, 0, Year);
                    comm.Parameters.Append(param);
                    param:=comm.CreateParameter('@duration', 3, 1, 0,"Ending Date of I part"-"Starting Date of I part");
                    comm.Parameters.Append(param);

                    comm.Execute;
                    conn.Close;
                    CLEAR(conn);
                    CLEAR(comm);
                    */

            end;
        }
        field(16; "Starting Date of II part"; Date)
        {
            Caption = 'Starting Date of II part';
        }
        field(17; "Ending Date of II part"; Date)
        {
            Caption = 'Ending Date of II part';
        }
        field(19; "Based on Disabled Child"; Integer)
        {
            Caption = 'Based onn Disabled Child';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
            end;
        }
        field(20; "Valid Vacation"; Boolean)
        {
            Caption = 'Valid Vacation';
        }
        field(21; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(22; "Max Days"; Decimal)
        {
            /*CalcFormula = Max(OpRisk.Quantity WHERE(Employee No.=FIELD(Employee No.)));
            FieldClass = FlowField;*/
        }
        field(23; "Used Days"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Absence" WHERE("Employee No." = FIELD("Employee No."),
                                                          "Vacation from Year" = FIELD(Year)));

        }
        field(24; "To Send"; Boolean)
        {
            Caption = 'To Send';
        }
        field(25; Sent; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }
        field(26; Status; enum "Employee Status")
        {

            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';


        }
        field(27; "Manager contract"; Boolean)
        {
            Caption = 'Manager contract';
        }
        field(28; "Number of days"; Integer)
        {

            trigger OnValidate()
            begin
                IF ("Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days") < 0 THEN
                    ERROR(Text01);

                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Year)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        EVALUATE(Order, "Employee No.");
        "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Disabled Child" + "Days based on Disability" - "Number of days";
    end;

    trigger OnModify()
    begin
        //"Total days":= "Legal Grounds"+"Days based on Work experience" +"Based on Disabled Child"+ "Days based on Disability";
    end;

    var
        t_Employee: Record "Employee";
        PositionRec: Record "Position";
        EmployeeRec: Record "Employee";
        CurrYear: Integer;
        LastDateOfMonth: Date;
        VacationSetup: Record "Vacation Setup";
        VacationCalculation: Report "Vacation Calculation";
        UsedDaysThisYear: Integer;
        Year2: Integer;
        WB: Record "Work Booklet";
        PlanGO: Record "Vacation Grounds";
        ECL: Record "Employee Contract Ledger";
        Absence: Record "Employee Absence";
        UsedDays: Integer;
        Experience: Record "Points per Experience Years";
        SocialStatus: Record "Points per Disability Status";
        /* SQLConn: DotNet SqlConnection;
         ConnectionString: Text;
         SQLCommand: DotNet SqlCommand;
         SQLParameter: DotNet SqlParameter;
         SQLDbType: DotNet DbType;
         WPConnSetup: Record "Web portal connection setup";
         conn: Automation;
         comm: Automation;
         param: Automation;
         lvarActiveConnection: Variant;*/
        Text01: Label 'You can''t insert number od used days more then available value!';




}

