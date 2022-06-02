page 50059 "Vacation Usage Plan"
{
    Caption = 'Vacation Usage Plan';
    PageType = List;
    SourceTable = "Vacation Ground 2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Caption = 'Employee No.';
                }
                field("First Name"; "First Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                //ED 02 START
                field("Position Name"; "Position Name")
                {
                }
                field(Sector; Sector)
                {
                }
                //ED 02 END
                field("Work experience"; "Work experience")
                {
                }
                field("Legal Grounds"; "Legal Grounds")
                {
                }
                field("Days based on Work experience"; "Days based on Work experience")
                {
                }
                field("Days based on Disability"; "Days based on Disability")
                {
                }
                //ED 02 START
                field("Days based on Military service"; "Days based on Military service")
                {
                }
                field("Days based on Working conditions"; "Days based on Working conditions")
                {
                }
                field("Used days at previous employer"; "Used days at previous employer")
                {
                    trigger OnValidate()
                    begin
                        Rec."Total days" := Rec."Total days" - "Used days at previous employer";
                    end;
                }
                //ED 02 END
                field("Total days"; "Total days")
                {
                }
                field(Year; Year)
                {
                }
                field("Date of report"; "Date of report")
                {

                }
                field("Starting Date of I part"; "Starting Date of I part")
                {
                }
                field("Ending Date of I part"; "Ending Date of I part")
                {
                }
                field("Starting Date of II part"; "Starting Date of II part")
                {
                    Editable = true;
                }
                field("Ending Date of II part"; "Ending Date of II part")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Vacation Usage Plan Calculation")
            {
                Caption = 'Vacation Usage Plan Calculation';
                Image = PlanningWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //ĐK RunObject = Report 50012;
                RunObject = report 50010; //ED 

                trigger OnAction()
                begin
                    CurrPage.UPDATE;
                end;
            }
            action("Annual Leave Resolution")
            {
                Caption = 'Annual Leave Resolution';
                Image = Report2;

                trigger OnAction()
                begin
                    //SM start
                    /*ĐK  Selection := STRMENU(Text0004,1);
                              IF Selection = 0 THEN
                                EXIT;
                              IF  Selection IN [1] THEN BEGIN
                              t_VG.SETCURRENTKEY("Employee No.");
                                  t_VG.SETFILTER("Employee No.",xRec."Employee No.");
                                  t_VG.SETFILTER(Year,FORMAT(xRec.Year));
                                  R_AnnualLeave.SETTABLEVIEW(t_VG);
                                  R_AnnualLeave.RUN;

                              END;
                              IF Selection IN [2] THEN BEGIN
                              t_VG.SETCURRENTKEY("Employee No.");
                                  t_VG.SETFILTER("Employee No.",xRec."Employee No.");
                                  t_VG.SETFILTER(Year,FORMAT(xRec.Year));

                                  R_AnnualLeave2.SETTABLEVIEW(t_VG);
                                  R_AnnualLeave2.RUN;

                              END;


                      //SMend





                      /*Temp:=CONFIRM(Text0002);

                      IF Temp=TRUE THEN BEGIN
                        IF t_emp.GET("Employee No.") THEN BEGIN
                        IF (("Ending Date of I part" = 0D)  OR  ("Starting Date of I part" = 0D)) THEN
                          ERROR(Text0001,t_emp."First Name",t_emp."Last Name");
                          t_VG.SETCURRENTKEY("Employee No.");
                          t_VG.GET("Employee No.",Year);
                          R_AnnualLeave.SETTABLEVIEW(t_VG);
                          R_AnnualLeave.RUN;
                        END;
                      END;

                      Temp:=CONFIRM(Text0003);
                      IF Temp=TRUE THEN BEGIN
                        IF t_emp.GET("Employee No.") THEN BEGIN
                        IF (("Ending Date of II part" = 0D)  OR  ("Starting Date of II part" = 0D)) THEN
                          ERROR(Text0001,t_emp."First Name",t_emp."Last Name");
                          t_VG.SETCURRENTKEY("Employee No.");
                          t_VG.GET("Employee No.",Year);
                          R_AnnualLeave2.SETTABLEVIEW(t_VG);
                          R_AnnualLeave2.RUN;
                        END;
                      END;
                             */

                    /*
                    IF t_emp.GET("Employee No.") THEN BEGIN
                      IF (("Starting Date of II part" = 0D) AND ("Ending Date of II part" <> 0D)) THEN
                        MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name")  ;
                      IF (("Ending Date of I part" = 0D)  AND  ("Starting Date of I part" = 0D)) THEN
                        MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name");
                      ELSE IF "Ending Date of II part" = 0D THEN
                         MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name")
                      ELSE IF "Ending Date of I part" = 0D THEN
                         MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name")
                    END;
                    */

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrentYear := (DATE2DMY(TODAY, 3));
        LastYear := (DATE2DMY(TODAY, 3) - 1);
        SETRANGE(Year, LastYear, CurrentYear);
    end;

    var
        //ĐKR_AnnualLeave: Report "50044";
        //ĐK R_AnnualLeave2: Report "50045";
        Text0001: Label 'Vacation period is not entered for %1 %2.';
        t_emp: Record "Employee";
        Temp: Boolean;
        Text0002: Label 'Do you want to print Annual Leave Resolution for first part of leave?';
        Text0003: Label 'Do you want to print Annual Leave Resolution for second part of leave?';
        //t_VG: Record "Vacation Grounds2";
        VG: Record "Vacation Ground 2";
        Selection: Integer;
        Text0004: Label 'Annual Leave Resolution for I part,Annual Leave Resolution for II part';
        t: Text;
        CurrentYear: Integer;
        LastYear: Integer;
}

