page 50066 "HR activities"
{
    // 

    PageType = CardPart;
    SourceTable = "HR Cue";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }
            cuegroup(Employees2)
            {
                Caption = 'Employees';


                field("New Employees"; "New Employees")
                {
                    ApplicationArea = all;
                    Image = People;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = ProfileID = 'TRAINING MANAGER';
                }
                field(Employees; Employees)
                {
                    ApplicationArea = all;
                    Caption = 'Employees';

                    Importance = Promoted;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                }
                field("Active Employees"; "Active Employees")
                {
                    ApplicationArea = all;

                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Potential Employees"; "Potential Employees")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("On Boarding"; "On Boarding")
                {
                    Caption = 'On Boarding';
                    Importance = Additional;
                    Visible = true;
                    ApplicationArea = all;
                }
            }
            cuegroup("Absence")
            {
                Caption = 'Absence';


                field("Inactive Employees"; "Inactive Employees")
                {
                    Caption = 'Inactive Employees';
                    Image = People;
                    Importance = Additional;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Inactive - Terminated"; "Inactive - Terminated")
                {
                    Image = People;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Terminated  Unpaid Employees"; "Terminated  Unpaid Employees")
                {
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }

            }


            cuegroup(Employees3)
            {
                Caption = 'External Employee';

                field(Practicians; Practicians)
                {
                    Image = People;
                    Importance = Promoted;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }



                field("Temporary Contract"; "Temporary Contract")
                {
                    Image = People;
                    ApplicationArea = all;
                }
                field(Volonteer; Volonteer)
                {
                    Image = People;
                    ApplicationArea = all;
                }


            }




            cuegroup(Warnings)
            {

                Caption = 'Warnings';
                Visible = ProfileID <> 'TRAINING MANAGER';

                field("Three Years In Company"; "Three Years In Company")
                {
                    Caption = 'Employees reaching out 3 years in SBBH';
                    Image = Calendar;
                    Style = Attention;
                    StyleExpr = true;
                    ApplicationArea = all;
                }
                field("Expiring Contracts"; "Expiring Contracts")
                {
                    Image = Receipt;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Expired Contracts"; "Expired Contracts")
                {
                    ApplicationArea = all;
                }
            }
            cuegroup(Probation)
            {
                Caption = 'Probation';
                Visible = ProfileID <> 'TRAINING MANAGER';

                field("Employees on Probation"; "Employees on Probation")
                {
                    Image = Diagnostic;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Probation Expires in NextPerio"; "Probation Expires in NextPerio")
                {
                    Caption = 'Probation Expires in Next Period';
                    Image = Diagnostic;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Probation expired"; "Probation expired")
                {
                    Image = Diagnostic;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }


            }
            cuegroup("Unsegmented Positions1")
            {
                Caption = 'Unsegmented Positions';
                Visible = false;


                field("Unsegmented Positions"; "Unsegmented Positions")
                {
                    Visible = show;
                    ApplicationArea = all;
                }

            }
            cuegroup(Information)
            {
                Caption = 'Information';
                Visible = show;

                field("For Calculation"; "For Calculation")
                {

                    Visible = false;
                    ApplicationArea = all;
                }
                field(Calculated; Calculated)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("New Employees FC"; "New Employees FC")
                {
                    Image = Checklist;
                    Importance = Additional;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Terminated Employees"; "Terminated Employees")
                {
                    Image = Checklist;
                    Importance = Additional;
                    Visible = show;
                    ApplicationArea = all;
                }
                field(Transfers; Transfers)
                {
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Temporary Disposition"; "Temporary Disposition")
                {
                    LookupPageID = "Employee Contract Ledger";
                    ApplicationArea = all;
                }

            }
            cuegroup("Changes")
            {
                Caption = 'Changes';
                Visible = show;

                field("Surname Change"; "Surname Change")
                {
                    Image = Checklist;
                    Importance = Additional;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Adress Change"; "Adress Change")
                {
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Education Level Change"; "Education Level Change")
                {
                    Image = Library;
                    Importance = Promoted;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
            }
            cuegroup("Fund")
            {

                Caption = 'Fund or Union Employees';


                field("Internal Fund"; "Internal Fund")
                {
                    Visible = show;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //Đ.K.
                    end;
                }
                field("External Fund"; "External Fund")
                {
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Union Employees"; "Union Employees")
                {
                    Visible = show;
                    ApplicationArea = all;
                }

            }


            /*  cuegroup("Potential Employees1")
              {
                  Caption = 'Potential Employees2';
                  Visible = false;


                  field("Invited to Interview"; "Invited to Interview")
                  {
                      ApplicationArea = all;
                  }
                  field("Appropriate Candidates"; "Appropriate Candidates")
                  {
                      ApplicationArea = all;
                  }
                  field("Inappropriate Candidates"; "Inappropriate Candidates")
                  {
                      ApplicationArea = all;
                  }


              }*/
            cuegroup(Trainings1)
            {
                Caption = 'Trainings';
                Visible = show;


                /*field("Education And Development"; "Education And Development")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }*/

                field("Training Catalogue"; "Training Catalogue")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Training Entry"; "Training Entry")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Employee Training Ledger"; "Employee Training Ledger")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = all;

                }
                field(Training; Training)
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field(Certification; Certification)
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }


            }

            /* cuegroup(Postings)
             {
                 Caption = 'Postings';

                 field(OpenPostingAll; OpenPostingAll)
                 {
                     ApplicationArea = all;
                 }
                 field(OpenPostingInternal; OpenPostingInternal)
                 {
                 }
                 field(OpenPostingExternal; OpenPostingExternal)
                 {
                     ApplicationArea = all;
                 }
                 field(OpenPostingBase; OpenPostingBase)
                 {
                     ApplicationArea = all;
                 }
                 field(ClosedPostingCompleted; ClosedPostingCompleted)
                 {
                     ApplicationArea = all;
                 }
                 field(ClosedPostingNoChoice; ClosedPostingNoChoice)
                 {
                     ApplicationArea = all;
                 }
                 field(ClosedPosting; ClosedPosting)
                 {xd
                     ApplicationArea = all;
                 }
             }
               cuegroup(Candidates)
                {
                    Caption = 'Candidates';

                    field(CandidatesGFSarajevo; CandidatesGFSarajevo)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFZenica; CandidatesGFZenica)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFBanjaLuka; CandidatesGFBanjaLuka)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFMostar; CandidatesGFMostar)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFTuzla; CandidatesGFTuzla)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFBihac; CandidatesGFBihac)
                    {
                        ApplicationArea = all;
                    }
                }
                cuegroup("L")
                {
                    Caption = '';


                    field(EconomicProfileLastYear; EconomicProfileLastYear)
                    {
                        ApplicationArea = all;
                    }
                    field(EconomicProfileThisYear; EconomicProfileThisYear)
                    {
                        ApplicationArea = all;
                    }
                    field(LawFacultyLastYear; LawFacultyLastYear)
                    {
                        ApplicationArea = all;
                    }
                    field(LawFacultyThisYear; LawFacultyThisYear)
                    {
                        ApplicationArea = all;
                    }
                    field(ElectricalLastYear; ElectricalLastYear)
                    {
                        ApplicationArea = all;
                    }
                    field(ElectricalThisYear; ElectricalThisYear)
                    {
                        ApplicationArea = all;
                    }
                */
            /* cuegroup("Disciplinary Measures")
             {
                 Caption = 'Disciplinary Measures';
                 Visible = show;

                 field("Active Measures"; "Active Measures")
                 {
                     ApplicationArea = all;
                 }
                 field("Expirings Measures"; "Expirings Measures")
                 {
                     ApplicationArea = all;
                 }

                 actions
                 {
                     action("<Page Training Catalogue11>")
                     {
                         Caption = 'NewEmployee99';
                         RunObject = Page "Employee Card";
                         RunPageMode = Create;
                     }

                 }
             }*/

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        HRsetup.GET;
        Date := 20010101D;
        Date2 := CALCDATE(HRsetup."Probation Expire Days", TODAY);
        Date3 := 20991231D;
        Date10 := CALCDATE(HRsetup."Expiry period (contracts)", TODAY);
        Date11 := CALCDATE('-30D', TODAY);
        Date4 := CALCDATE('-' + FORMAT(HRsetup."Reaching years in company"), CALCDATE(HRsetup."Warning Period", TODAY));
        //DateFilter:=0D;
        //MESSAGE(FORMAT(DateFIlter2));
        SETRANGE(DateFIlter, TODAY, Date2);
        SETRANGE(DateFilter2, Date, TODAY);
        SETRANGE(DateFilter3, TODAY, Date3);
        SETRANGE(DateFilter10, TODAY, Date10);
        SETRANGE(DateFilter11, Date11, TODAY);
        SETRANGE(DateFilter4, CALCDATE('-' + FORMAT(HRsetup."Reaching years in company"), TODAY), Date4);
        SETRANGE(DateFilter5, CALCDATE('-' + FORMAT(HRsetup."New employee period"), TODAY), TODAY);
        SETRANGE(DateFilter12, Date, TODAY);
        SETRANGE("Expirings Measures Filter", CALCDATE('<-3D>', TODAY), TODAY);
        SETRANGE(LastYearFilter, DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1), DMY2DATE(31, 12, DATE2DMY(TODAY, 3) - 1));
        SETRANGE(ThisYearFilter, DMY2DATE(1, 1, DATE2DMY(TODAY, 3)), DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));
        SetRange(DateTraining, CalcDate('<-30D>', Today), Today);
        SetRange(DateCatalogue, CalcDate('<-30D>', Today), Today);


        UP.SETFILTER("User ID", '%1', USERID);
        IF UP.FINDFIRST THEN
            ProfileID := UP."Profile ID";
        DateTraining := CALCDATE(HRsetup."Legal Training Expire Days", TODAY);
        SETRANGE(DateFilterTraining, TODAY, DateTraining);

        if GlobalLanguage = 1033 then
            ThisMonthFirst := CALCDATE('-CM', WORKDATE)
        else
            ThisMonthFirst := CALCDATE('-SM', WORKDATE);


        if GlobalLanguage = 1033 then
            ThisMonthLast := CALCDATE('CM', WORKDATE)
        else
            ThisMonthLast := CALCDATE('SM', ThisMonthFirst);
        NextMonthFirst := CALCDATE('+1D', ThisMonthLast);


        if GlobalLanguage = 1033 then
            NextMonthLast := CALCDATE('CM', NextMonthFirst)
        else
            NextMonthLast := CALCDATE('SM', NextMonthFirst);



        if GlobalLanguage = 1033 then
            DBThisMonthLast := CALCDATE('CM-1D', NextMonthFirst)
        else
            DBThisMonthLast := CALCDATE('SM-1D', ThisMonthFirst);


        if GlobalLanguage = 1033 then
            DBThisMonthFirst := CALCDATE('-CM-1D', WORKDATE)
        else
            DBThisMonthFirst := CALCDATE('-SM-1D', WORKDATE);




        //  DBThisMonthFirst := CALCDATE('-SM-1D;', WORKDATE);
        SETRANGE(DateFilter6, ThisMonthFirst, ThisMonthLast);
        SETRANGE(DateFilter7, ThisMonthFirst, DBThisMonthLast);
        SETRANGE(DateFilter8, 0D, DBThisMonthFirst);
        SETRANGE(DateFilter9, CALCDATE('+1D;', ThisMonthFirst), ThisMonthLast);

        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF UserPersonalisation."Profile ID" <> 'LEGAL' THEN
                show := TRUE
            ELSE
                show := FALSE;
        END;

        UserPersonalisation2.RESET;
        UserPersonalisation2.SETFILTER("User ID", USERID);
        IF UserPersonalisation2.FINDFIRST THEN BEGIN
            IF UserPersonalisation2."Profile ID" <> 'HR READ' THEN BEGIN





                /*
                ECLHO.SETFILTER("Ending Date",'%1',CALCDATE('-1D',WORKDATE));
                IF ECLHO.FIND('-') THEN BEGIN
                    HeadOfRefresh.SETFILTER("ORG Shema",'%1',ECLHO."Org. Structure");
                    HeadOfRefresh.SETFILTER("Position Code",'%1',ECLHO."Position Code");
                   IF HeadOfRefresh.FINDLAST THEN BEGIN
                   REPORT.RUNMODAL(50050,FALSE,TRUE);
                 //   REPORT.RUNMODAL(19,FALSE,TRUE);

                     END;*/
            END;

            OrgShema.RESET;
            OrgShema.SETFILTER(Status, '%1', 0);
            IF OrgShema.FINDLAST THEN BEGIN
                "Active Sistematizaction" := OrgShema.Code;
                SETFILTER("Active Sistematizaction", OrgShema.Code);
            END
            ELSE BEGIN
                "Active Sistematizaction" := '';
            END;

            /*
            ECLHO2.SETFILTER("Starting Date",'%1',CALCDATE('0D',WORKDATE));
            IF ECLHO2.FIND('-') THEN BEGIN
                HeadOfRefresh2.SETFILTER("ORG Shema",'%1',ECLHO2."Org. Structure");
                HeadOfRefresh2.SETFILTER("Position Code",'%1',ECLHO2."Position Code");
               IF HeadOfRefresh2.FINDLAST THEN BEGIN
               REPORT.RUNMODAL(50050,FALSE,TRUE);
               REPORT.RUNMODAL(19,FALSE,TRUE);
                 END;
              END;*/




            //STATUS UPDATE
            /*ECL2.SETFILTER(Active,'%1',TRUE);
            ECL2.SETFILTER("Reason for Change",'%1',ECL2."Reason for Change"::"New Contract");
            ECL2.SETFILTER("Starting Date",'%1',TODAY);
            IF ECL2.FIND('-') THEN REPEAT

              Employee2.SETFILTER("No.",'%1',ECL2."Employee No.");
              Employee2.SETFILTER(Status,'<>%1',Employee2.Status::Active);
              IF Employee2.FIND('-') THEN
                BEGIN
                  IF Employee2.Status<4 THEN
                  Employee2.Status:=Employee2.Status::Active
                  ELSE
                  Employee2."External employer Status":=Employee2."External employer Status"::Active;
                  Employee2.MODIFY;

                END;

            UNTIL ECL2.NEXT=0;
            */
            //NAPISATI ISPOD ECL
            /*EmployeeContractLedger2.RESET;
            EmployeeContractLedger2.SETFILTER("Grounds for Term. Code",'<>%1','');
            IF EmployeeContractLedger2.FINDSET THEN REPEAT
              EmployeeContractLedger.RESET;
              EmployeeContractLedger.SETFILTER("Employee No.",'%1',EmployeeContractLedger2."Employee No.");
              EmployeeContractLedger.SETFILTER("No.",'>%1',EmployeeContractLedger2."No.");
              EmployeeContractLedger.SETFILTER("Starting Date",'<=%1',WORKDATE);
              IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                EmployeeContractLedger2.Active:=FALSE;
                EmployeeContractLedger2.MODIFY;
            IF EmployeeContractLedger."Starting Date" <=WORKDATE THEN BEGIN
               Employee.RESET;
                  Employee.SETFILTER("No.",'%1',EmployeeContractLedger2."Employee No.");
              IF Employee.FIND('-') THEN BEGIN

                  IF Employee.StatusExt=Employee.Status::Terminated   THEN BEGIN
                  Employee.StatusExt:=Employee.Status::Active;
                  Employee.MODIFY;
                   END;
                END;
               EmployeeContractLedger.VALIDATE("Starting Date",WORKDATE);
              EmployeeContractLedger. MODIFY(TRUE);
              END;
               END

             ELSE BEGIN
               IF EmployeeContractLedger2."Ending Date"<=WORKDATE THEN BEGIN
               EmployeeContractLedger2.VALIDATE("Grounds for Term. Code",EmployeeContractLedger2."Grounds for Term. Code");
               EmployeeContractLedger2.MODIFY;
               END;
                //END;

                END;



            UNTIL EmployeeContractLedger2.NEXT=0;*/

            /* //STATUS UPDATE
            ECLOrg9.RESET;
            ECLOrg9.SETFILTER("Org. Structure",'%1',OrgShema.Code);
            ECLOrg9.SETFILTER("Show Record",'%1',TRUE);
            ECLOrg9.SETFILTER("Position Description",'<>%1','');
            ECLOrg9.SETFILTER("Starting Date",'%1',CALCDATE('<-1D>',WORKDATE));
            IF ECLOrg9.FINDSET THEN BEGIN
                 REPORT.RUNMODAL(213,FALSE,FALSE,ECLOrg9);
                COMMIT;
             END;*/



        END;
    END;

    // end;

    var
        UserPersonalisation2: Record "User Personalization";
        show: Boolean;
        UserPersonalisation: Record "User Personalization";
        ECLHO: Record "Employee Contract Ledger";
        HeadOfRefresh: Record "Head Of's";
        ECLHO2: Record "Employee Contract Ledger";
        HeadOfRefresh2: Record "Head Of's";
        Date: Date;
        Date2: Date;
        Date3: Date;
        Date4: Date;
        HRsetup: Record "Human Resources Setup";
        UP: Record "User Personalization";
        ProfileID: Text;
        DateTraining: Date;
        ThisMonthFirst: Date;
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        NextMonthLast: Date;
        DBThisMonthLast: Date;
        DBThisMonthFirst: Date;
        Date10: Date;
        Date11: Date;
        ECL: Record "Employee Contract Ledger";
        Employee: Record "Employee";
        ECL2: Record "Employee Contract Ledger";
        Employee2: Record "Employee";
        OrgShema: Record "ORG Shema";
        SistematizationCode: Code[10];
        OrgShema1: Record "ORG Shema";
        OrgShema2: Record "ORG Shema";
        SectorTemp: Record "Sector temporary";
        SectorOrginal: Record "Sector";
        DepCatOrginal: Record "Department Category";
        DepCatTemp: Record "Department Category temporary";
        GroupOrginal: Record "Group";
        GroupTemp: Record "Group temporary";
        TeamOrginal: Record "TeamT";
        TeamTemp: Record "Team temporary";
        DepartmentOrginal: Record "Department";
        DepartmentTemp: Record "Department temporary";
        HeadOfOrginal: Record "Head Of's";
        HeadOfTemp: Record "Head Of's temporary";
        DimensionOrginalPos: Record "Dimension for position";
        DimensionTempPos: Record "Dimension temp for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuTemp: Record "Position Menu temporary";
        PositionMenuOrginal: Record "Position Menu";
        ECLOrg11: Record "Employee Contract Ledger";
        PositionMenuOrginal1: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        ECLSyst: Record "ECL systematization";
        ECLOrg: Record "Employee Contract Ledger";
        PoSMenDUp: Record "Position Menu";
        Brojac: Integer;
        ECLSis: Record "ECL systematization";
        Novi: Integer;
        PositionIDFind: Record "Position";
        DimensionForPos: Record "Dimension for position";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        ECLBefore: Record "Employee Contract Ledger";
        OrgShemaA: Record "ORG Shema";
        ReportNotification: Report "Systematization e-mail";
        SectorOrginal1: Record "Sector";
        DepCatOrginal1: Record "Department Category";
        GroupOrginal1: Record "Group";
        TeamOrginal1: Record "TeamT";
        DepartmentOrginal1: Record "Department";
        HeadOfOrginal1: Record "Head Of's";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsOrginal1: Record "Position Benefits";
        ECLOrg1: Record "Employee Contract Ledger";
        PositionBenef: Record "Position Benefits";
        MAIS: Record "Misc. Article Information";
        MAI1: Record "Misc. Article Information";
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        DepartmentCodeForpos: Code[30];
        ORGDijelovi: Record "Org Dijelovi";
        ECLSYSEmail: Report "Systematization e-mail";
        ECLForEmail: Record "Employee Contract Ledger";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        WorkBooklet: Record "Work Booklet";
        EmployeeContractChangeOrgRename: Record "Employee Contract Ledger";
        EmployeeContractChangeOrg: Record "Employee Contract Ledger";
        CheckConflict: Record "Employee Contract Ledger";
        BR: Record "Employee Contract Ledger";
        ECLSYSTChangeBR: Record "ECL systematization";
        ECLCheck: Record "Employee Contract Ledger";
        ECLOrg8: Record "Employee Contract Ledger";
        ECLOrg9: Record "Employee Contract Ledger";
        WDV: Record "Work Duties Violation";
}

