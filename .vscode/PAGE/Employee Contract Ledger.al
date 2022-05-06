page 50051 "Employee Contract Ledger"
{
    Caption = 'Employee Contract Ledger';
    DelayedInsert = true;
    Editable = true;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = false;
    SourceTable = "Employee Contract Ledger";
    SourceTableView = WHERE("Show Record" = FILTER(true));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group3)
            {
                Editable = true;
                Enabled = true;
                field("No."; "No.")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field(Contract; Contract)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Operator No."; "Operator No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Internal ID"; "Internal ID")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Reason for Change"; "Reason for Change")
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change")
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Contract Phase"; "Contract Phase")
                {
                    BlankZero = true;
                    Editable = false;
                    Importance = Promoted;
                    ShowMandatory = true;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Contract Phase Time"; "Contract Phase Time")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Contract Phase Date"; "Contract Phase Date")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Team; Team)
                {

                    Editable = false;
                    Enabled = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("<Team Description>"; "Team Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("<Group>"; Group)
                {

                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Department Cat. Description"; "Department Cat. Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    Editable = false;
                    Enabled = true;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Sector Description"; "Sector Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Branch Agency"; "Branch Agency")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Org Dio"; "Org Dio")
                {
                    //  BlankZero = true;
                    ShowMandatory = true;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department City"; "Department City")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("GF rada code"; "GF rada code")
                {
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        /*EmployeeContractLedger.RESET;
                        EmployeeContractLedger.SETFILTER(Status,'Active');
                        EmployeeContractLedger.SETFILTER("Employee No.","Employee No.");
                        EmployeeContractLedger.SETFILTER("Org. Structure","Org. Structure");
                        IF ("GF rada"<>'') AND ("Org Dio"='') THEN BEGIN
                          OrgDijelovi.RESET;
                          OrgDijelovi.SETFILTER(Active,'1');
                          OrgDijelovi.SETFILTER(Code,"Org Dio");
                          IF OrgDijelovi.FINDFIRST THEN
                          "Phisical Department Desc":= OrgDijelovi.City
                        {ELSE BEGIN
                        VALIDATE("Phisical Department Desc","Phisical Department Desc");
                         END;}
                         END;*/

                    end;
                }
                field("Org Unit Name"; "Org Unit Name")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        CurrPage.UPDATE;
                    end;
                }
                field("GF of work Description"; "GF of work Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        CurrPage.UPDATE;
                    end;
                }
                field("Phisical Department Desc"; "Phisical Department Desc")
                {
                    ApplicationArea = all;
                }
                field(Region; Region)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Regionalni Head Office"; "Regionalni Head Office")
                {
                    ApplicationArea = all;
                }
                field("Org Entity Code"; "Org Entity Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Org Municipality"; "Org Municipality")
                {

                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Org Municipality of ag"; "Org Municipality of ag")
                {
                    ApplicationArea = all;
                }
                field("Municipality Name"; "Municipality Name")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Department Address"; "Department Address")
                {
                    ApplicationArea = all;
                }
                field("<Position Description>"; "Position Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        CurrPage.UPDATE;
                    end;
                }
                field("Engagement Type"; "Engagement Type")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; "Contract Type")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Contract Type Name"; "Contract Type Name")
                {
                    Editable = true;

                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //CurrPage.UPDATE;
                    end;
                }
                field("Starting Date"; "Starting Date")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Ending Date"; "Ending Date")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Work Years"; "Work Years")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Work Months"; "Work Months")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Work Days"; "Work Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("First Time Employed"; "First Time Employed")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field(Prentice; Prentice)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Testing Period"; "Testing Period")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF "Testing Period" = TRUE THEN
                            "Testing Period Starting Date" := "Starting Date"
                        ELSE
                            IF "Testing Period" = FALSE THEN BEGIN
                                "Testing Period Starting Date" := 0D;
                                "Testing Period Ending Date" := 0D;
                                "Probation Days" := 0;
                                "Probation Months" := 0;
                                "Probation Year" := 0;
                                MODIFY;


                                //CurrPage.UPDATE;

                            END;
                    end;
                }
                field("Testing Period Starting Date"; "Testing Period Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Testing Period Ending Date"; "Testing Period Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Probation Year"; "Probation Year")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Probation Months"; "Probation Months")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Probation Days"; "Probation Days")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Testing Period Successful"; "Testing Period Successful")
                {
                    ApplicationArea = all;
                }
                field("Testing Period - Comment"; "Testing Period - Comment")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field(Brutto; Brutto)
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        /*IF Brutto<>0 THEN BEGIN
                          CALCFIELDS(Region);
                        PayRange.SETFILTER("Pay Grade",'%1',Region);
                        IF PayRange.FINDFIRST THEN BEGIN
                          IF Brutto<PayRange."Min Region" THEN
                           MESSAGE(BruttoError);
                          IF Brutto>PayRange."Max Region" THEN
                           MESSAGE (BruttoError);
                        END;
                        CurrPage.UPDATE;
                        END;*/

                        //CurrPage.UPDATE;
                        CurrPage.UPDATE;

                    end;
                }
                field(Netto; Netto)
                {
                    Editable = true;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Percentage of Fixed Part"; "Percentage of Fixed Part")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Fixed Amount Brutto"; "Fixed Amount Brutto")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Fixed Amount Netto"; "Fixed Amount Netto")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Percentage of Variable"; "Percentage of Variable")
                {

                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Variable Amount Brutto"; "Variable Amount Brutto")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Variable Amount Netto"; "Variable Amount Netto")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("BJF/GJF"; "BJF/GJF")
                {

                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Additional Benefits"; "Additional Benefits")
                {
                    ApplicationArea = all;
                }
                field("Employee Benefits"; "Employee Benefits")
                {
                    ApplicationArea = all;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                }
                field("Temporary disposition"; "Temporary disposition")
                {
                    ApplicationArea = all;
                }
                field("Temporary disposition starting"; "Temporary disposition starting")
                {
                    ApplicationArea = all;
                }
                field("Temporary disposition ending"; "Temporary disposition ending")
                {
                    ApplicationArea = all;
                }
                field("<Minimal Education Levell>"; "Minimal Education Level")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(KPI; KPI)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Prohibition of Competition"; "Prohibition of Competition")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("POC Starting Date"; "POC Starting Date")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("POC Ending Date"; "POC Ending Date")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field(IS; IS)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("IS Risk Materiality"; "IS Risk Materiality")
                {
                    ApplicationArea = all;
                }
                field("IS Date From"; "IS Date From")
                {
                    ApplicationArea = all;
                }
                field("IS Date To"; "IS Date To")
                {
                    ApplicationArea = all;
                }
                field("Key Function"; "Key Function")
                {
                    ApplicationArea = all;
                }
                field("Key Function From"; "Key Function From")
                {

                    Editable = true;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Key Function To"; "Key Function To")
                {

                    Editable = true;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Control Function"; "Control Function")
                {
                    ApplicationArea = all;
                }
                field("Control Function From"; "Control Function From")
                {
                    ApplicationArea = all;
                }
                field("Control Function To"; "Control Function To")
                {
                    ApplicationArea = all;
                }
                field("Way of Employment"; "Way of Employment")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Manner of Term. Description"; "Manner of Term. Description")
                {
                    ApplicationArea = all;
                }
                field("Manner of Term. Code"; "Manner of Term. Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Grounds for Term. Description"; "Grounds for Term. Description")
                {
                    ApplicationArea = all;
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Exit Interview"; "Exit Interview")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Employment Abroad"; "Employment Abroad")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Employment Abroad City"; "Employment Abroad City")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Empl.Abroad Country/Region"; "Empl.Abroad Country/Region")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Manager 1"; "Manager 1")
                {

                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Manager 1 First Name"; "Manager 1 First Name")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Manager 1 Last Name"; "Manager 1 Last Name")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Manager 2"; "Manager 2")
                {
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Manager 2 First Name"; "Manager 2 First Name")
                {
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Manager 2 Last Name"; "Manager 2 Last Name")
                {
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Agremeent Code"; "Agremeent Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Agreement Name"; "Agreement Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //CurrPage.UPDATE;

                        CurrPage.UPDATE;
                    end;
                }
                field("Comment for contract"; "Comment for contract")
                {

                    ApplicationArea = all;
                }
                field("Attachment No."; "Attachment No." <> 0)
                {

                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF "Attachment No." <> 0 THEN
                            OpenAttachment;


                        CurrPage.UPDATE;
                    end;
                }
                field(Change; Change)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Certifications and solutions C"; "Certifications and solutions C")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Cert and solu name"; "Cert and solu name")
                {
                    ApplicationArea = all;
                }
                field("Other Attachment No."; "Other Attachment No." <> 0)
                {

                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF "Other Attachment No." <> 0 THEN
                            OpenAttachment1;

                        CurrPage.UPDATE;
                    end;
                }
                field("Change other documents"; "Change other documents")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Number of certification"; "Number of certification")
                {
                    ApplicationArea = all;
                }
                field("Additional Position"; "Additional Position")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Additional Responsiblity"; "Additional Responsiblity")
                {
                    ApplicationArea = all;
                }
                field("Number of protocol for documen"; "Number of protocol for documen")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Sent Mail Termination"; "Sent Mail Termination")
                {
                    ApplicationArea = all;
                }
                field("Sent Mail Duration"; "Sent Mail Duration")
                {
                    ApplicationArea = all;
                }
                field("Sent Mail Change Pos"; "Sent Mail Change Pos")
                {
                    ApplicationArea = all;
                }
                field("Sent Mail Employment"; "Sent Mail Employment")
                {
                    ApplicationArea = all;
                }
                field(Superior1; Superior1)
                {
                    ApplicationArea = all;
                }
                field(Superior2; Superior2)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Custom report layouts")
            {
                Caption = 'Custom report layouts';
                Image = Agreement;
                RunObject = Page "Custom Report Layouts";
                Visible = IsVisible;
                ApplicationArea = all;
            }
            group(Process)
            {
                Caption = 'Process';
                //The property 'ToolTip' cannot be empty.
                //ToolTip = '';
                action(Copy)
                {
                    Caption = 'Copy';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    Scope = Page;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin

                        ECLCopy.COPY(Rec, FALSE);
                        ECLCopy2.SETFILTER("No.", '<>%1', 0);
                        IF ECLCopy2.FINDLAST THEN
                            ECLCopy."No." := ECLCopy2."No." + 1
                        ELSE
                            ECLCopy."No." := 1;
                        ECLCopy."Operator No." := USERID;
                        ECLCopy.Active := FALSE;
                        ECLCopy."Attachment No." := 0;
                        ECLCopy."Reason for Change" := 0;
                        ECLCopy."Ending Date" := 0D;
                        //ECLCopy.VALIDATE("Starting Date",TODAY);
                        ECLCopy."Starting Date" := 0D;
                        ECLCopy.Change := FALSE;
                        ECLCopy.VALIDATE("Manner of Term. Description", '');
                        ECLCopy.VALIDATE("Grounds for Term. Description", '');
                        ECLCopy.VALIDATE("Contract Type Name", '');
                        ECLCopy.Status := 1;
                        ECLCopy."Agreement Name" := '';
                        ECLCopy."Agremeent Code" := '';
                        ECLCopy."Sent Mail Change Pos" := FALSE;
                        ECLCopy."Sent Mail Duration" := FALSE;
                        ECLCopy."Sent Mail Employment" := FALSE;
                        ECLCopy."Sent Mail Termination" := FALSE;

                        ECLCopy.INSERT(TRUE);
                        IF Rec."Org. Structure" <> ECLCopy."Org. Structure" THEN BEGIN
                            Dep.RESET;
                            Dep.SETFILTER("ORG Shema", '%1', ECLCopy."Org. Structure");
                            Dep.SETFILTER(Code, '%1', ECLCopy."Department Code");
                            Dep.SETFILTER(Description, '%1', ECLCopy."Department Name");
                            IF Dep.FINDFIRST THEN BEGIN
                                IF Dep."Department Type" = 8 THEN BEGIN
                                    ECLCopy.VALIDATE("Sector Description", '');
                                    ECLCopy.VALIDATE("Sector Description", Dep."Sector  Description");
                                    ECLCopy.MODIFY;
                                    PositionRec.RESET;
                                    PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                    PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                    PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                    IF PositionRec.FINDFIRST THEN BEGIN
                                        ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                        ECLCopy.MODIFY;
                                    END
                                    ELSE BEGIN
                                        ECLCopy.VALIDATE("Position Description", '');
                                    END;
                                END;

                                IF Dep."Department Type" = 4 THEN BEGIN
                                    ECLCopy.VALIDATE("Department Cat. Description", '');
                                    ECLCopy.VALIDATE("Department Cat. Description", Dep."Department Categ.  Description");
                                    ECLCopy.MODIFY;
                                    PositionRec.RESET;
                                    PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                    PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                    PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                    IF PositionRec.FINDFIRST THEN BEGIN
                                        ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                        ECLCopy.MODIFY;
                                    END
                                    ELSE BEGIN
                                        ECLCopy.VALIDATE("Position Description", '');
                                    END;
                                END;
                                IF Dep."Department Type" = 2 THEN BEGIN
                                    ECLCopy.VALIDATE("Group Description", '');
                                    ECLCopy.VALIDATE("Group Description", Dep."Group Description");
                                    ECLCopy.MODIFY;
                                    PositionRec.RESET;
                                    PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                    PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                    PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                    IF PositionRec.FINDFIRST THEN BEGIN
                                        ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                        ECLCopy.MODIFY;
                                    END
                                    ELSE BEGIN
                                        ECLCopy.VALIDATE("Position Description", '');
                                    END;
                                END;
                                IF Dep."Department Type" = 9 THEN BEGIN
                                    ECLCopy.VALIDATE("Team Description", '');
                                    ECLCopy.VALIDATE("Team Description", Dep."Team Description");
                                    ECLCopy.MODIFY;
                                    PositionRec.RESET;
                                    PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                    PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                    PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                    IF PositionRec.FINDFIRST THEN BEGIN
                                        ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                        ECLCopy.MODIFY;
                                    END
                                    ELSE BEGIN
                                        ECLCopy.VALIDATE("Position Description", '');
                                    END;
                                END;
                            END
                            ELSE BEGIN
                                ECLCopy.VALIDATE("Sector Description", '');
                                ECLCopy.VALIDATE("Position Description", '');
                                ECLCopy.MODIFY;
                            END;

                        END;
                    end;
                }
                action("Copy Orginal")
                {
                    Caption = 'Copy';
                    ApplicationArea = all;
                    Image = Copy;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    Scope = Page;

                    trigger OnAction()
                    begin

                        ECLCopy.COPY(Rec, FALSE);
                        ECLCopy2.SETFILTER("No.", '<>%1', 0);
                        IF ECLCopy2.FINDLAST THEN
                            ECLCopy."No." := ECLCopy2."No." + 1
                        ELSE
                            ECLCopy."No." := 1;
                        ECLCopy."Operator No." := USERID;

                        ECLCopy.INSERT(TRUE);
                    end;
                }
                action(RunReport)
                {
                    Caption = 'RunReport';
                    ApplicationArea = all;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*DR.SETFILTER("Agreement Code",'%1',Rec."Agremeent Code");
                        IF DR.FIND('-') THEN BEGIN
                          CRL.SETFILTER("Report ID",'%1',DR."NAV Agreement Code");
                          IF CRL.FIND('-') THEN BEGIN
                           ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                           IF "Agremeent Code"='26' THEN BEGIN
                            ContractR.SetParam("Employee No.",'26');
                             // REPORT.RUNMODAL(DR."NAV Agreement Code");
                            ContractR.RUN;
                            CreateAttachment;
                            END;
                            IF "Agremeent Code"='262' THEN BEGIN
                              ECL.RESET;
                              ECL.SETFILTER("Employee No.","Employee No.");
                              IF ECL.FINDLAST THEN BEGIN
                              ContractP.SetParam("Employee No.");
                            ContractP.RUN;
                              END;
                              END;
                        
                            //REPORT.RUNMODAL(DR.NAV Agreement Code");
                           ReportLayoutSelection.SetTempLayoutSelected(0);
                           END;
                          END;
                          */

                    end;
                }
                action(Open1)
                {
                    Caption = 'Open';
                    Image = Edit;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    ShortCutKey = 'Return';

                    trigger OnAction()
                    begin
                        OpenAttachment;

                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;
                    ApplicationArea = all;
                    Image = New;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CreateAttachment;
                    end;
                }
                action("Copy_from")
                {
                    Caption = 'Copy_from';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        CopyFromAttachment;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        //ImportAttachment;
                        Change := TRUE;
                        MODIFY;
                        IF "Attachment No." <> 0 THEN BEGIN
                            IF Attachment.GET("Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            /* IF NOT CONFIRM(Text001,FALSE) THEN
                               EXIT;*/
                        END;
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF ECL.FIND('-') THEN BEGIN
                            BrojUgovora := ECL.COUNT;
                        END;
                        //ĐK   Attachment.SetParam(Rec."Employee No.", Rec."No.", 1);
                        IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) THEN BEGIN
                            "Attachment No." := Attachment."No.";
                            /* Change:=TRUE;
                             MODIFY;*/
                        END;
                        /*END ELSE
                          ERROR(Text002);*/

                    end;
                }
                action("Export")
                {
                    Caption = 'Export';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        ExportAttachment;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        RemoveAttachment(TRUE);
                    end;
                }
                action(Open2)
                {
                    Caption = 'Open';
                    Image = Edit;
                    ApplicationArea = all;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = New;
                    ShortCutKey = 'Return';

                    trigger OnAction()
                    begin
                        OpenAttachment1;
                    end;
                }
                action(Create1)
                {
                    Caption = 'Create1';
                    Ellipsis = true;
                    Image = New;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CreateAttachment1;
                    end;
                }
                action("Copy_from1")
                {
                    Caption = 'Copy_from1';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = New;
                    ApplicationArea = all;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CopyFromAttachment1;
                    end;
                }
                action(Import1)
                {
                    Caption = 'Import1';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        //ImportAttachment1;
                        //ImportAttachment;

                        "Change other documents" := TRUE;
                        MODIFY;
                        IF "Other Attachment No." <> 0 THEN BEGIN
                            IF Attachment.GET("Other Attachment No.") THEN
                                Attachment.TESTFIELD("Read Only", FALSE);
                            /* IF NOT CONFIRM(Text001,FALSE) THEN
                               EXIT;*/
                        END;
                        ECL.RESET;
                        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF ECL.FIND('-') THEN BEGIN
                            BrojUgovora := ECL.COUNT;
                        END;
                        //ĐK     Attachment.SetParam(Rec."Employee No.", Rec."No.", 2);
                        IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) THEN BEGIN
                            "Other Attachment No." := Attachment."No."
                        END;

                    end;
                }
                action("E_xport1")
                {
                    Caption = 'E_xport1';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ExportAttachment1;
                    end;
                }
                action(Remove1)
                {
                    Caption = 'Remove1';
                    Ellipsis = true;
                    ApplicationArea = all;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        RemoveAttachment1(TRUE);
                    end;
                }
                action("<Action80>")
                {
                    Caption = 'Auto Import';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = New;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        // Auto Uvoz

                        /*DR.SETFILTER("Agreement Code",'%1',Rec."Agremeent Code");
                        IF DR.FINDLAST THEN BEGIN
                          CRL.SETFILTER("Report ID",'%1',DR."NAV Agreement Code");
                          IF CRL.FINDLAST THEN BEGIN
                           ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        
                          IF "Agremeent Code"='26' THEN BEGIN
                            ContractR.SetParam("Employee No.",'26');
                        
                              // REPORT.RUNMODAL(DR."NAV Agreement Code");
                        
                              //ContractR.RUN;
                              //CreateAttachment;
                        
                              tempSaveDest := 'C:\Temp\autouvoz_'+FORMAT(WORKDATE)+'.doc';
                        
                              // Prepare for temporary file allocation and word save
                              // Specify that the temporary is opened as a binary file.
                              tempFile.TEXTMODE(FALSE);
                        
                              // Specify that you can write to temporary file.
                              tempFile.WRITEMODE(TRUE);
                        
                              // Create and open tempFile.
                              tempFile.CREATE(tempSaveDest);
                        
                              // Close TempFile so that the SAVEASWORD function can write to it.
                              tempFile.CLOSE;
                        
                              // Call the save function providing the temporary destination path
                              ContractR.SAVEASWORD(tempSaveDest);
                        
                              // Now opeon the temp file from the temporary save destination
                              tempFile.OPEN(tempSaveDest);
                        
                              // Create a new binary stream for the temmporary file
                              tempFile.CREATEINSTREAM(NewStream);
                        
                            END;
                        
                            IF "Agremeent Code"='262' THEN BEGIN
                              ECL.RESET;
                              ECL.SETFILTER("Employee No.","Employee No.");
                              IF ECL.FINDLAST THEN BEGIN
                                ContractP.SetParam("Employee No.");
                                ContractP.RUN;
                                //ContractR.SAVEASWORD('C:\test.docx');
                              END;
                            END;
                        
                            //REPORT.RUNMODAL(DR.NAV Agreement Code");
                          ReportLayoutSelection.SetTempLayoutSelected(0);
                          END;
                          END;
                        
                        */

                        // Run
                        //CRL2.SETFILTER("Report ID",'%1',DR."NAV Agreement Code"); // 99001047 ce biti DR."NAV Agreement Code"
                        //CRL2.SETFILTER("Report ID",'%1',99001047);
                        //IF CRL2.FINDLAST THEN BEGIN
                        //  ReportLayoutSelection.SetTempLayoutSelected(CRL2.ID);
                        //  Certificatematernity.SetParam("Employee No.");
                        //  Certificatematernity.RUN;
                        //END;
                        //ReportLayoutSelection.SetTempLayoutSelected(0);

                        //MESSAGE('Auto izvoz prema: '+'C:\Windows\Temp\Ugovor_'+FORMAT(DR."NAV Agreement Code"));

                        // Export
                        //CLEAR(ReportLayoutSelection);
                        //Certificatematernity.SAVEASWORD('C:\Windows\Temp\Ugovor_'+FORMAT(DR."NAV Agreement Code"));

                        // Import
                        // Importujemo tkoji smo exportovali u atachmente

                    end;
                }
                action("Show/Hide record")
                {
                    Caption = 'Show/Hide record';
                    RunObject = Report "ECL Show/Hide record";
                    ApplicationArea = all;
                }
            }
            group(Certifications1)
            {
                Caption = 'Certifications';
                Visible = false;
                group(Certifications2)
                {
                    Caption = 'Certifications';
                    Image = LotInfo;
                    action("Certificate for maternity leave")
                    {
                        Caption = 'Certificate for maternity leav';
                        Image = "Report";
                        ApplicationArea = all;

                        trigger OnAction()
                        begin
                            CRL2.SETFILTER("Report ID", '%1', 99001047);
                            IF CRL2.FIND('-') THEN BEGIN
                                //ĐK  ReportLayoutSelection.SetTempLayoutSelected(CRL2.ID);
                                // Certificatematernity.SetParam("Employee No.");
                                //  Certificatematernity.RUN;
                            END;
                            //    ReportLayoutSelection.SetTempLayoutSelected(0);

                        end;
                    }
                }
            }
            group(Forms1)
            {
                Caption = 'Forms';
                Image = LotInfo;


                action(PD3100)
                {
                    Caption = 'PD3100';
                    ApplicationArea = all;
                    Image = Document;

                    trigger OnAction()
                    begin
                        //  CLEAR(ObrazacPD300);
                        // ObrazacPD300.SetParam(Rec."Employee No.", Rec."No.");
                        //ObrazacPD300.RUN;
                    end;
                }
                action(JS3100)
                {
                    Caption = 'JS3100';
                    Image = Document;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        //   CLEAR(ObrazacJS3100);
                        // ObrazacJS3100.SetParam(Rec."Employee No.", Rec."No.");
                        //ObrazacJS3100.RUN;
                    end;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Show Record", '%1', TRUE);
        Rec.FILTERGROUP(0);

        IF ("Testing Period Successful" = "Testing Period Successful"::" ") AND ("Testing Period Ending Date" = CALCDATE('<-1D>', TODAY)) THEN BEGIN
            "Testing Period Successful" := "Testing Period Successful"::Yes
        END;
        /*PosNew.RESET;
        PosNew.SETFILTER("Employee No.",'%1',"Employee No.");
        PosNew.SETFILTER("Org. Structure",'%1',"Org. Structure");
        PosNew.SETFILTER("Changing Position",'%1',TRUE);
        IF PosNew.FINDLAST THEN BEGIN
           IF PosNew.Description<>Rec."Position Description" THEN BEGIN
             Rec."Position Description":=PosNew.Description;
             EmployeeContractLedger.SETFILTER("Employee No.",'%1',PosNew."Employee No.");
             IF EmployeeContractLedger.FINDLAST THEN BEGIN
             EmployeeContractLedger.VALIDATE("Position Description",PosNew.Description);
             END;
             END;
             END;*/


        IF "Employee No." <> '' THEN
            EVALUATE(Order, "Employee No.");
        "Registration Date" := "Starting Date";


        /*EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER(Status,'Active');
        EmployeeContractLedger.SETFILTER("Employee No.","Employee No.");
        EmployeeContractLedger.SETFILTER("Org. Structure","Org. Structure");
        IF "Org Dio"<>'' THEN BEGIN
          OrgDijelovi.SETFILTER(Code,"Org Dio");
          OrgDijelovi.SETFILTER("ORG Shema","Org. Structure");
          IF OrgDijelovi.FINDFIRST THEN BEGIN
          "Regional Head Officey":= OrgDijelovi."Regionalni Head Office";
        END
        ELSE BEGIN
         "Regional Head Officey":='';
         END;
         END;
         */
        EmployeeContractLedger.RESET;
        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
        EmployeeContractLedger.SETFILTER("Employee No.", Rec."Employee No.");
        EmployeeContractLedger.SETFILTER("Org. Structure", "Org. Structure");
        EmployeeContractLedger.SETFILTER("No.", '%1', Rec."No.");
        IF EmployeeContractLedger.FINDLAST THEN BEGIN
            ContractPhase.RESET;
            ContractPhase.SETFILTER("Employee No.", EmployeeContractLedger."Employee No.");
            ContractPhase.SETFILTER("Contract Ledger Entry No.", '%1', EmployeeContractLedger."No.");
            ContractPhase.SETFILTER(Active, '%1', TRUE);
            IF ContractPhase.FINDLAST THEN BEGIN
                "Contract Phase" := ContractPhase."Contract Phase";
                "Contract Phase Time" := ContractPhase."Contract Phase Time";
                "Contract Phase Date" := ContractPhase."Contract Phase Date";
            END;
        END;
        EmployeeContractLedger.CALCFIELDS("Manager 1");
        EmployeeContractLedger.CALCFIELDS("Manager 1 First Name");
        EmployeeContractLedger.CALCFIELDS("Manager 1 Last Name");
        EmployeeContractLedger.CALCFIELDS("Manager 1 Position Code");
        EmployeeContractLedger.CALCFIELDS("Manager 1 Position ID");
        EmployeeContractLedger.CALCFIELDS("Manager 2");
        EmployeeContractLedger.CALCFIELDS("Manager 2 First Name");
        EmployeeContractLedger.CALCFIELDS("Manager 2 Last Name");
        EmployeeContractLedger.CALCFIELDS("Manager 2 Position Code");


    end;

    trigger OnClosePage()
    begin
        CALCFIELDS("Minimal Education Level");
        //CALCFIELDS("Residence/Network","Department Name","Department Address","Department City","B-1","B-1 (with regions)",Stream);
        CALCFIELDS("Residence/Network");
        //CALCFIELDS("Sector Description","Department Cat. Description","Group Description");
        CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name", "Manager 1 Position Code");
        CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name", "Manager 2 Position Code");

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //đ.k
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF xRec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := xRec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF Rec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := Rec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF NOT CONFIRM(Text000, FALSE) THEN BEGIN
            Rec := xRec;
            xRec.TRANSFERFIELDS(Rec);
            //IF Rec."Identity Sector"=0 THEN BEGIN

            FilterEmployeeNo := Rec.GETFILTER("Employee No.");
            CurrPage.UPDATE(FALSE);
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF xRec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := xRec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF Rec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := Rec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        Izmjena := FALSE;
        "Registration Date" := "Starting Date";
        IF ((USERID <> 'MBDOM\HRAPP') AND (USERID <> 'MBDOM\FEDJA.BOGDANOVIC')) THEN
            "Operator No." := USERID;
        IF (xRec."Starting Date" <> Rec."Starting Date") THEN
            // AND (Rec."Reason for Change"=Rec."Reason for Change"::"New Contract")) THEN
            VALIDATE("Starting Date", Rec."Starting Date");
        IF xRec."Team Description" <> Rec."Team Description" THEN BEGIN
            VALIDATE("Team Description", Rec."Team Description");
            Izmjena := TRUE;
        END;
        IF xRec."Group Description" <> Rec."Group Description" THEN BEGIN
            VALIDATE("Group Description", Rec."Group Description");
            Izmjena := TRUE;
        END;
        IF xRec."Department Cat. Description" <> Rec."Department Cat. Description" THEN BEGIN
            VALIDATE("Department Cat. Description", Rec."Department Cat. Description");
            Izmjena := TRUE;
        END;

        IF xRec."Sector Description" <> Rec."Sector Description" THEN BEGIN
            VALIDATE("Sector Description", Rec."Sector Description");
            Izmjena := TRUE;
        END;

        IF (xRec."Position Description" = Rec."Position Description") AND (Izmjena = TRUE) THEN
            VALIDATE("Position Description", Rec."Position Description");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OsActive.RESET;
        OsActive.SETFILTER(Status, '%1', 0);
        IF OsActive.FINDLAST THEN BEGIN
            "Org. Structure" := OsActive.Code;
        END
        ELSE BEGIN
            "Org. Structure" := '';
        END;
    end;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Show Record", '%1', TRUE);
        Rec.FILTERGROUP(0);

        /*   UserPersonalisation.RESET;
           UserPersonalisation.SETFILTER("User ID", USERID);
           IF UserPersonalisation.FINDFIRST THEN BEGIN
               IF UserPersonalisation."Profile ID" <> 'PAYROLL' THEN
                   show := TRUE
               ELSE
                   show := FALSE;
           END;*/

        //REPORT.RUNMODAL(50050,FALSE,TRUE);


        CALCFIELDS("Minimal Education Level");
        //CALCFIELDS("Residence/Network","Department Name","Department Address","Department City","B-1","B-1 (with regions)",Stream);
        CALCFIELDS("Residence/Network");
        //CALCFIELDS("Sector Description","Department Cat. Description","Group Description");
        CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name", "Manager 1 Position Code");
        CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name", "Manager 2 Position Code");
        SETCURRENTKEY(Order);
        CALCFIELDS("Contract Phase");
        CALCFIELDS("Contract Phase Date");
        CALCFIELDS("Contract Phase Time");
        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);

        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF UserPersonalisation."Profile ID" = 'HR OPERATER' THEN
                IsVisible := FALSE
            ELSE
                IsVisible := TRUE;
        END;
        IF ("Testing Period Successful" = "Testing Period Successful"::" ") AND ("Testing Period Ending Date" = CALCDATE('<-1D>', TODAY)) THEN BEGIN
            "Testing Period Successful" := "Testing Period Successful"::Yes
        END;

        /*  PosNew.RESET;
        PosNew.SETFILTER("Employee No.",'%1',"Employee No.");
        PosNew.SETFILTER("Org. Structure",'%1',"Org. Structure");
        PosNew.SETFILTER("Changing Position",'%1',TRUE);
        IF PosNew.FINDLAST THEN BEGIN
        IF PosNew.Description<>Rec."Position Description" THEN BEGIN
        Rec."Position Description":=PosNew.Description;
        EmployeeContractLedger.SETFILTER("Employee No.",'%1',PosNew."Employee No.");
        IF EmployeeContractLedger.FINDLAST THEN BEGIN
        EmployeeContractLedger.VALIDATE("Position Description",PosNew.Description);
        END;
        END;
        END;
        */
        SETCURRENTKEY("Starting Date");
        ASCENDING(FALSE);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        CurrPage.UPDATE;
        IsUpadate := FALSE;
        /*IF "No."<>0 THEN BEGIN
        IF (("GF of work Description"='') AND ("Org Unit Name"='')) THEN
          ERROR ('Morate unijeti Org. jed!');
        TESTFIELD ("Position Description");
        IF ("Engagement Type"<>'EXTERNI ANGAZMAN') THEN BEGIN
          IF  (("Management Level"<>"Management Level"::CEO) AND ("Management Level"<>"Management Level"::Exe)) THEN
        TESTFIELD (Brutto);
        END;
         TESTFIELD("Starting Date");
        END;
        OrgF.RESET;
        OrgF.SETFILTER(Status,'%1',OrgF.Status::Active);
        IF OrgF.FINDLAST THEN BEGIN
          OrgC:=OrgF.Code;
          END;
        
        // IF WORKDATE>=CALCDATE('<-1D>',OrgShema."Date From") THEN BEGIN
        
         //REPORT.RUNMODAL(50050, FALSE, TRUE);
         {*****************************************"TERMINATION"*******************************************}
         IF COMPANYNAME='RAIFFAISEN BANK' THEN BEGIN
        
           EmailBodyText5:='';
        ECL4.RESET;
        ECL4.SETFILTER("Show Record",'%1',TRUE);
        ECL4.SETFILTER("Position Description",'<>%1','');
        ECL4.SETFILTER("Starting Date",'<>%1',0D);
        ECL4.SETFILTER("Grounds for Term. Code",'<>%1','');
        ECL4.SETFILTER("Grounds for Term. Description",'<>%1','');
        ECL4.SETFILTER("Sent Mail Termination",'%1',FALSE);
        ECL4.SETFILTER("Ending Date",'<=%1',CALCDATE('<+1D>',WORKDATE));
        IF ECL4.FINDFIRST THEN BEGIN
          NemaNiko:=FALSE;
        
           EmailBodyText5+='<p><span style="font-size: 9.0pt; font-family: "Tahoma">Po&scaron;tovani,';
           EmailBodyText5+='<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadleznosti u vezi sa prestankom rada/angazmana navedene osobe.';
           EmailBodyText5+='<br /> <br />';
            EmailBodyText5+='<br /> <br />';
            EmailBodyText5 += '<table cellpadding="5" style="border-collapse: collapse;border-left: solid 1px black;  " border="1">';
        // EmailBodyText2 += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
         EmailBodyText5 += '<tr style="Border:solid 1px black;">';
           EmailBodyText5+='<td style="border-left:solid 0px black;width:250px" style="border-bottom:solid 1px black" ><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
           EmailBodyText5+=' <td width="250 "style="border-bottom:solid 1px black" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
           EmailBodyText5+='<td  style="border-bottom:solid 1px black ;width:200px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;  JMBG  &nbsp</strong> </td>';
           EmailBodyText5+='<td  width="270" style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;"> ORGANIZACIONA PRIPADNOST&nbsp</strong></td>';
           EmailBodyText5+='<td   width="250" style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;RADNO&nbsp; MJESTO&nbsp;</strong></td>';
           EmailBodyText5+='<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;ZADNJI RADNI DAN&nbsp;&nbsp;</strong></td>';
           EmailBodyText5+='<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> VRSTA ANGAZMANA/PERSON TYPE/&nbsp</strong></td>';
           EmailBodyText5+='<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   ROLA  &nbsp;&nbsp;&nbsp;</strong></td>';
           EmailBodyText5+='<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">Neposredni &nbsp; rukovodilac&nbsp</strong></td>';
           EmailBodyText5+='</tr>';
        
        ECL5.RESET;
        ECL5.SETFILTER("Show Record",'%1',TRUE);
        ECL5.SETFILTER("Position Description",'<>%1','');
        ECL5.SETFILTER("Starting Date",'<>%1',0D);
        ECL5.SETFILTER("Grounds for Term. Code",'<>%1','');
        ECL5.SETFILTER("Grounds for Term. Description",'<>%1','');
        ECL5.SETFILTER("Sent Mail Termination",'%1',FALSE);
        ECL5.SETFILTER("Ending Date",'<=%1',CALCDATE('<+1D>',WORKDATE));
        IF ECL5.FINDSET THEN REPEAT
           IF IsUpadate=FALSE THEN BEGIN
            REPORT.RUNMODAL(50050, FALSE, TRUE);
            IsUpadate:=TRUE;
            END;
            NemaNiko:=TRUE;
        
        
          CLEAR(TextMsg);
          CLEAR(IStream);
          CLEAR(Mail);
        
          IF ECL5."Team Description"<>'' THEN BEGIN
            OrgUnit:=ECL5."Sector Description"+'/'+ ECL5."Department Cat. Description"+'/'+ ECL5."Group Description"+'/'+ECL5."Team Description";
          END;
          IF (ECL5."Group Description"<>'') AND (ECL5."Team Description"='') THEN BEGIN
            OrgUnit:=ECL5."Sector Description"+'/'+ ECL5."Department Cat. Description"+'/'+ ECL5."Group Description";
          END;
          IF (ECL5."Department Cat. Description"<>'') AND (ECL5."Group Description"='') AND (ECL5."Team Description"='') THEN BEGIN
            OrgUnit:= ECL5."Sector Description"+'/'+ ECL5."Department Cat. Description";
          END;
          IF (ECL5."Sector Description"<>'') AND (ECL5."Department Cat. Description"='') AND (ECL5."Group Description"='') AND (ECL5."Team Description"='') THEN BEGIN
            OrgUnit:=ECL5."Sector Description"
          END;
          IF (ECL5."Sector Description"='') AND (ECL5."Department Cat. Description"='') AND (ECL5."Group Description"='') AND (ECL5."Team Description"='') THEN BEGIN
            OrgUnit:='';
            WorkPlace:='';
          END;
          IF ECL5."Org Unit Name"<>'' THEN BEGIN
            WorkPlace:=ECL5."Org Unit Name";
          END
          ELSE BEGIN
            WorkPlace:=ECL5."GF of work Description";
          END;
        
        IF ECL5."Org Unit Name"<>'' THEN
          MjestoRada:=ECL5."Org Unit Name";
        IF ECL5."GF of work Description"<>'' THEN
          MjestoRada:=ECL5."GF of work Description";
        
          StartingDate:=ECL5."Starting Date";
          ECL5.CALCFIELDS("Residence/Network");
          ECL5.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
           ECL5.CALCFIELDS("Manager 2 First Name","Manager 2 Last Name");
          ManagerFull:=ECL5."Manager 1 First Name"+' '+ECL5."Manager 1 Last Name";
          IF  ECL5."Manager 1 First Name"='' THEN
              ManagerFull:=ECL5."Manager 2 First Name"+' '+ECL5."Manager 2 Last Name";
          Emp.SETFILTER("No.",'%1',ECL5."Employee No.");
        
          IF Emp.FINDFIRST THEN BEGIN
            Emp.CALCFIELDS("Role Code");
            Emp.CALCFIELDS("Role Name");
          END;
        
          PositionMenuOrginal.RESET;
        PositionMenuOrginal.SETFILTER(Code,'%1',ECL5."Position Code");
        PositionMenuOrginal.SETFILTER(Description,'%1',ECL5."Position Description");
        PositionMenuOrginal.SETFILTER("Org. Structure",'%1',OrgF.Code);
        IF PositionMenuOrginal.FINDFIRST THEN BEGIN
        RoleCode:=PositionMenuOrginal.Role;
        RoleName:=PositionMenuOrginal."Role Name";
        END;
        
        IF ECL5."Engagement Type"='EXTERNI ANGAZMAN' THEN
         Tip:='Eksterni saradnik'
         ELSE
         Tip:='Zaposlenik';
        
          //EmailBodyText2+= '<tr><span style="font-size: 10.0pt;">';
          EmailBodyText5+= '<tr>';
          EmailBodyText5+=STRSUBSTNO('<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
          EmailBodyText5+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
          EmailBodyText5+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>',Emp."Employee ID");
          EmailBodyText5+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit);
           EmailBodyText5+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>' ,ECL5."Position Description");
          EmailBodyText5+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',FORMAT(ECL5."Ending Date",0,'<Day,2>.<Month,2>.<Year4>.'));
          EmailBodyText5+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',Tip);
          EmailBodyText5+=STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>',RoleCode+'-'+RoleName);
          EmailBodyText5+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
           EmailBodyText5+='</tr>';
              ECLCHange.RESET;
           ECLCHange.SETFILTER("Employee No.",'%1',ECL5."Employee No.");
           ECLCHange.SETFILTER("No.",'%1',ECL5."No.");
           IF ECLCHange.FINDFIRST THEN BEGIN
             ECLCHange."Sent Mail Termination":=TRUE;
             ECLCHange.MODIFY;
             END;
           UNTIL ECL5.NEXT=0;
        
              EmailBodyText5+='</table>';
               // SMTPMail.CreateMessage('HR test','test.hr@raiffeisengroup.ba','infodom.test@raiffeisengroup.ba','Obavijest o pocetku rada na novoj poziciji',EmailBodyText2,TRUE);
                HRsetup.GET;
        
            SMTPMail.CreateMessage(HRsetup."Sender Name",HRsetup."E-mail Sender",HRsetup."E-mail Receiver",'Obavjest o prestanku radnog odnosa/angazmana',EmailBodyText5,TRUE);
            IF NemaNiko=TRUE THEN
           SMTPMail.Send();
        END;
        
        
        
        SETFILTER("Org. Structure",'%1',OrgC);
        SETFILTER("Show Record",'%1',TRUE);
        SETFILTER("Position Description",'<>%1','');
        SETFILTER("Starting Date",'<=%1',WORKDATE);
        IF FINDFIRST THEN BEGIN
        
        ECL.RESET;
        ECL.SETFILTER("Show Record",'%1',TRUE);
        ECL.SETFILTER("Position Description",'<>%1','');
        ECL.SETFILTER("Starting Date",'<=%1',WORKDATE);
        ECL.SETFILTER("Reason for Change",'%1',"Reason for Change"::"New Contract");
        ECL.SETFILTER(Active,'%1',TRUE);
        ECL.SETFILTER("Sent Mail Employment",'%1',FALSE);
        ECL.SETFILTER("Grounds for Term. Code",'%1','');
        ECL.SETFILTER("Manner of Term. Code",'%1','');
        IF ECL.FINDFIRST THEN BEGIN
        
        
        
         EmailBodyText+='<p><span style="font-size: 9.0pt; font-family: "Tahoma">Po&scaron;tovani,';
         EmailBodyText+='<br /> <br /> Molim da poduzmete potrebne aktivnosti u vezi sa pocetkom rada/angazmana navedene osobe. ';
         EmailBodyText+='<br /> <br />';
          EmailBodyText+='<br /> <br />';
          EmailBodyText += '<table cellpadding="5" style="border-collapse: collapse; border-left: solid 1px black; " border="1">';
         //EmailBodyText += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
         EmailBodyText += '<tr style="Border:solid 1px black;">';
         EmailBodyText+='<td style="border-left:solid 0px black;width:250px" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
         EmailBodyText+=' <td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
         EmailBodyText+='<td style="border-bottom:solid 1px black;width:200px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MATICNI &nbsp; &nbsp; BROJ&nbsp</strong> </td>';
         EmailBodyText+='<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> ORGANIZACIJSKA PRIPADNOST&nbsp</strong></td>';
         EmailBodyText+='<td width="250"style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;RADNO&nbsp;  MJESTO&nbsp;</strong></td>';
         EmailBodyText+='<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;MJESTO&nbsp;  RADA&nbsp;</strong></td>';;
         EmailBodyText+='<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> VRSTA ANGAZMANA/PERSON TYPE/&nbsp</strong></td>';
         EmailBodyText+='<td  width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">DATUM POCETKA RADA/ANGAZMANA&nbsp</strong> </td>';
         EmailBodyText+='<td width="250" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   ROLA   &nbsp;&nbsp;&nbsp;</strong></td>';
         EmailBodyText+='<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; Neposredni  &nbsp; rukovodilac&nbsp</strong></td>';
         EmailBodyText+='</tr>';
        
        ECL1.SETFILTER("Show Record",'%1',TRUE);
        ECL1.SETFILTER("Position Description",'<>%1','');
        ECL1.SETFILTER("Starting Date",'<=%1',WORKDATE);
        ECL1.SETFILTER("Reason for Change",'%1',"Reason for Change"::"New Contract");
        ECL1.SETFILTER("Sent Mail Employment",'%1',FALSE);
        ECL1.SETFILTER(Active,'%1',TRUE);
        ECL1.SETFILTER("Grounds for Term. Code",'%1','');
        ECL1.SETFILTER("Manner of Term. Code",'%1','');
        
        IF ECL1.FINDSET THEN REPEAT
           IF IsUpadate=FALSE THEN BEGIN
            REPORT.RUNMODAL(50050, FALSE, TRUE);
            IsUpadate:=TRUE;
            END;
        
        
          CLEAR(TextMsg);
          CLEAR(IStream);
          CLEAR(Mail);
        
        
            IF ECL1."Team Description"<>'' THEN BEGIN
               OrgUnit:=ECL1."Sector Description"+'/'+ ECL1."Department Cat. Description"+'/'+ ECL1."Group Description"+'/'+ECL1."Team Description";
                  END;
            IF (ECL1."Group Description"<>'') AND (ECL1."Team Description"='') THEN BEGIN
                 OrgUnit:=ECL1."Sector Description"+'/'+ ECL1."Department Cat. Description"+'/'+ ECL1."Group Description";
        
              END;
            IF (ECL1."Department Cat. Description"<>'') AND (ECL1."Group Description"='') AND (ECL1."Team Description"='') THEN BEGIN
              OrgUnit:= ECL1."Sector Description"+'/'+ ECL1."Department Cat. Description";
        
              END;
              IF (ECL1."Sector Description"<>'') AND (ECL1."Department Cat. Description"='') AND (ECL1."Group Description"='') AND (ECL1."Team Description"='') THEN BEGIN
                OrgUnit:=ECL1."Sector Description";
        
                END;
            IF (ECL1."Sector Description"='') AND (ECL1."Department Cat. Description"='') AND (ECL1."Group Description"='') AND (ECL1."Team Description"='') THEN BEGIN
              OrgUnit:='';
              END;
              PositionPlace:=ECL1."Position Description";
              StartingDate:=ECL1."Starting Date";
              ECL1.CALCFIELDS("Residence/Network");
              ECL1.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
               ECL1.CALCFIELDS("Manager 2 First Name","Manager 2 Last Name");
          ManagerFull:=ECL1."Manager 1 First Name"+' '+ECL1."Manager 1 Last Name";
          IF ECL1."Manager 1 First Name"='' THEN
             ManagerFull:=ECL1."Manager 2 First Name"+' '+ECL1."Manager 2 Last Name";
          Tip:='';
         Emp.SETFILTER("No.",'%1',ECL1."Employee No.");
          IF Emp.FINDFIRST THEN BEGIN
           // Emp.CALCFIELDS("Role Code");
           // Emp.CALCFIELDS("Role Name");*/
        /*
     PositionMenuOrginal.RESET;
     PositionMenuOrginal.SETFILTER(Code,'%1',ECL1."Position Code");
     PositionMenuOrginal.SETFILTER(Description,'%1',ECL1."Position Description");
     PositionMenuOrginal.SETFILTER("Org. Structure",'%1',OrgF.Code);
     IF PositionMenuOrginal.FINDFIRST THEN BEGIN
     RoleCode:=PositionMenuOrginal.Role;
     RoleName:=PositionMenuOrginal."Role Name";
     END;


     IF ECL1."Engagement Type"='EXTERNI ANGAZMAN' THEN
      Tip:='Eksterni saradnik'
      ELSE
      Tip:='Zaposlenik';



       END;

     IF ECL1."Org Unit Name"<>'' THEN
       MjestoRada:=ECL1."Org Unit Name";
     IF ECL1."GF of work Description"<>'' THEN
       MjestoRada:=ECL1."GF of work Description";

       EmailBodyText+= '<tr>';

      EmailBodyText+=STRSUBSTNO('<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
      EmailBodyText+=STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
      EmailBodyText+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',Emp."Employee ID");
      EmailBodyText+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit);
      EmailBodyText+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>' ,PositionPlace);
      EmailBodyText+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" ><span style="font-size: 10.0pt;">%1</td>',MjestoRada+'/'+ECL1."Phisical Department Desc");
      EmailBodyText+=STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',Tip);
      EmailBodyText+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', FORMAT(StartingDate,0,'<Day,2>.<Month,2>.<Year4>.'));
      EmailBodyText+=STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px"  bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',RoleCode+'-'+RoleName);
       EmailBodyText+=STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
        EmailBodyText+='</tr>';
        ECLCHange.RESET;
        ECLCHange.SETFILTER("Employee No.",'%1',ECL1."Employee No.");
        ECLCHange.SETFILTER("No.",'%1',ECL1."No.");
        IF ECLCHange.FINDFIRST THEN BEGIN
          ECLCHange."Sent Mail Employment":=TRUE;
          ECLCHange.MODIFY;
          END;
       UNTIL ECL1.NEXT=0;

        EmailBodyText+='</table>';
        HRsetup.GET;
         SMTPMail.CreateMessage(HRsetup."Sender Name",HRsetup."E-mail Sender",HRsetup."E-mail Receiver",'Obavijest o zaposljavanju/angazmanu',EmailBodyText,TRUE);

       SMTPMail.Send();

      END;


     {*****************************************"CHANGE POSITION PLACE"*******************************************}

     ECL4.RESET;
     ECL4.SETFILTER("Show Record",'%1',TRUE);
     ECL4.SETFILTER("Position Description",'<>%1','');
     ECL4.SETFILTER("Starting Date",'<>%1',0D);
     ECL4.SETFILTER("Reason for Change",'%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',3,7,8,9,10,12,4,11,15,16);
     ECL4.SETFILTER(Active,'%1',TRUE);
     ECL4.SETFILTER("Sent Mail Change Pos",'%1',FALSE);
     ECL4.SETFILTER("Grounds for Term. Code",'%1','');
     ECL4.SETFILTER("Manner of Term. Code",'%1','');
     IF ECL4.FINDFIRST THEN BEGIN


        EmailBodyText2+='<p><span style="font-size: 9.0pt; font-family: "Tahoma">Po&scaron;tovani,';
        EmailBodyText2+='<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadleznosti u vezi sa pocetkom rada navedene osobe na novoj poziciji i/ili organizaciji.';
        EmailBodyText2+='<br /> <br />';
         EmailBodyText2+='<br /> <br />';
         EmailBodyText2 += '<table cellpadding="5" style="border-collapse: collapse;border-left: solid 1px black;  " border="1">';
     // EmailBodyText2 += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
      EmailBodyText2 += '<tr style="Border:solid 1px black;">';
        EmailBodyText2+='<td style="border-left:solid 0px black;width:250px" style="border-bottom:solid 1px black" ><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
        EmailBodyText2+=' <td width="250" style="border-bottom:solid 1px black" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
        EmailBodyText2+='<td style="border-bottom:solid 1px black ;width:200px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;  JMBG  &nbsp</strong> </td>';
        EmailBodyText2+='<td  width="270" style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;"> NOVI RASPORED &nbsp</strong></td>';
        EmailBodyText2+='<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;VAZI&nbsp; OD&nbsp;</strong></td>';
        EmailBodyText2+='<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MJESTO  &nbsp;  RADA&nbsp;</strong></td>';
        EmailBodyText2+='<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   ROLA  &nbsp;&nbsp;&nbsp;</strong></td>';
        EmailBodyText2+='<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">Neposredni &nbsp; rukovodilac&nbsp</strong></td>';
        EmailBodyText2+='</tr>';

     ECL5.RESET;
     ECL5.SETFILTER("Show Record",'%1',TRUE);
     ECL5.SETFILTER("Position Description",'<>%1','');
     ECL5.SETFILTER("Starting Date",'<>%1',0D);
     ECL5.SETFILTER("Reason for Change",'%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',3,7,8,9,10,12,4,11,15,16);
     ECL5.SETFILTER(Active,'%1',TRUE);
     ECL5.SETFILTER("Sent Mail Change Pos",'%1',FALSE);
     ECL5.SETFILTER("Grounds for Term. Code",'%1','');
     ECL5.SETFILTER("Manner of Term. Code",'%1','');
     IF ECL5.FINDSET THEN REPEAT
        IF IsUpadate=FALSE THEN BEGIN
         REPORT.RUNMODAL(50050, FALSE, TRUE);
         IsUpadate:=TRUE;
         END;

       CLEAR(TextMsg);
       CLEAR(IStream);
       CLEAR(Mail);

       IF ECL5."Team Description"<>'' THEN BEGIN
         OrgUnit:=ECL5."Sector Description"+'/'+ ECL5."Department Cat. Description"+'/'+ ECL5."Group Description"+'/'+ECL5."Team Description";
       END;
       IF (ECL5."Group Description"<>'') AND (ECL5."Team Description"='') THEN BEGIN
         OrgUnit:=ECL5."Sector Description"+'/'+ ECL5."Department Cat. Description"+'/'+ ECL5."Group Description";
       END;
       IF (ECL5."Department Cat. Description"<>'') AND (ECL5."Group Description"='') AND (ECL5."Team Description"='') THEN BEGIN
         OrgUnit:= ECL5."Sector Description"+'/'+ ECL5."Department Cat. Description";
       END;
       IF (ECL5."Sector Description"<>'') AND (ECL5."Department Cat. Description"='') AND (ECL5."Group Description"='') AND (ECL5."Team Description"='') THEN BEGIN
         OrgUnit:=ECL5."Sector Description"
       END;
       IF (ECL5."Sector Description"='') AND (ECL5."Department Cat. Description"='') AND (ECL5."Group Description"='') AND (ECL5."Team Description"='') THEN BEGIN
         OrgUnit:='';
         WorkPlace:='';
       END;
       IF ECL5."Org Unit Name"<>'' THEN BEGIN
         WorkPlace:=ECL5."Org Unit Name";
       END
       ELSE BEGIN
         WorkPlace:=ECL5."GF of work Description";
       END;

     IF ECL5."Org Unit Name"<>'' THEN
       MjestoRada:=ECL5."Org Unit Name";
     IF ECL5."GF of work Description"<>'' THEN
       MjestoRada:=ECL5."GF of work Description";

       StartingDate:=ECL5."Starting Date";
       ECL5.CALCFIELDS("Residence/Network");
       ECL5.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
        ECL5.CALCFIELDS("Manager 2 First Name","Manager 2 Last Name");
       ManagerFull:=ECL5."Manager 1 First Name"+' '+ECL5."Manager 1 Last Name";
       IF  ECL5."Manager 1 First Name"='' THEN
           ManagerFull:=ECL5."Manager 2 First Name"+' '+ECL5."Manager 2 Last Name";
       Emp.SETFILTER("No.",'%1',ECL5."Employee No.");

       IF Emp.FINDFIRST THEN BEGIN
         Emp.CALCFIELDS("Role Code");
         Emp.CALCFIELDS("Role Name");
       END;

       PositionMenuOrginal.RESET;
     PositionMenuOrginal.SETFILTER(Code,'%1',ECL5."Position Code");
     PositionMenuOrginal.SETFILTER(Description,'%1',ECL5."Position Description");
     PositionMenuOrginal.SETFILTER("Org. Structure",'%1',OrgF.Code);
     IF PositionMenuOrginal.FINDFIRST THEN BEGIN
     RoleCode:=PositionMenuOrginal.Role;
     RoleName:=PositionMenuOrginal."Role Name";
     END;

       //EmailBodyText2+= '<tr><span style="font-size: 10.0pt;">';
       EmailBodyText2+= '<tr>';
       EmailBodyText2+=STRSUBSTNO('<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
       EmailBodyText2+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
       EmailBodyText2+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black ;width:250px" ><span style="font-size: 10.0pt;">%1</td>',Emp."Employee ID");
       EmailBodyText2+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit+'/'+ECL5."Position Description");
       EmailBodyText2+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',FORMAT(StartingDate,0,'<Day,2>.<Month,2>.<Year4>.'));
       EmailBodyText2+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',MjestoRada+'/'+ECL5."Phisical Department Desc");
       EmailBodyText2+=STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>',RoleCode+'-'+RoleName);
       EmailBodyText2+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
        EmailBodyText2+='</tr>';
           ECLCHange.RESET;
        ECLCHange.SETFILTER("Employee No.",'%1',ECL5."Employee No.");
        ECLCHange.SETFILTER("No.",'%1',ECL5."No.");
        IF ECLCHange.FINDFIRST THEN BEGIN
          ECLCHange."Sent Mail Change Pos":=TRUE;
          ECLCHange.MODIFY;
          END;
        UNTIL ECL5.NEXT=0;

           EmailBodyText2+='</table>';

            // SMTPMail.CreateMessage('HR test','test.hr@raiffeisengroup.ba','infodom.test@raiffeisengroup.ba','Obavijest o pocetku rada na novoj poziciji',EmailBodyText2,TRUE);
               HRsetup.GET;
         SMTPMail.CreateMessage(HRsetup."Sender Name",HRsetup."E-mail Sender",HRsetup."E-mail Receiver",'Obavijest o pocetku rada na novoj poziciji',EmailBodyText2,TRUE);
        SMTPMail.Send();
     END;









          {**********************************************DURATION************************************************}
     ECL2.RESET;
     ECL2.SETFILTER("Show Record",'%1',TRUE);
     ECL2.SETFILTER("Position Description",'<>%1','');
     ECL2.SETFILTER("Starting Date",'<>%1',0D);
     //ECL2.SETFILTER("Reason for Change",'%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',3,7,8,9,10,12,4,11,15,16);
     ECL2.SETFILTER("Sent Mail Change Pos",'%1',TRUE);
     ECL2.SETFILTER("Sent Mail Duration",'%1',FALSE);
     ECL2.SETFILTER("Grounds for Term. Code",'%1','');
     ECL2.SETFILTER("Manner of Term. Code",'%1','');
     IF ECL2.FINDFIRST THEN BEGIN


      EmailBodyText1+='<p><span style="font-size: 10.0pt; font-family: "Tahoma">Po&scaron;tovani,';
        EmailBodyText1+='<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadleznosti, u vezi sa izmjenom trenutnog rasporeda koji vazi do datuma kako je navedeno u tabeli';
        EmailBodyText1+='<br /> <br />';
         EmailBodyText1+='<br /> <br />';
           EmailBodyText1 += '<table cellpadding="5" style="border-collapse: collapse; border-left: solid 1px black;   " border="1">';
        // EmailBodyText1 += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
         EmailBodyText1 += '<tr style="Border:solid 1px black;">';
        EmailBodyText1+='<td style="border-left:solid 0px black;width:250px" style="border-bottom:solid 1px black"><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
        EmailBodyText1+=' <td width="250" style="border-bottom:solid 1px black" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
        EmailBodyText1+='<td  style="border-bottom:solid 1px black;width:200px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   JMBG  &nbsp; &nbsp</strong> </td>';
        EmailBodyText1+='<td  width="270" style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;"> STARI RASPORED&nbsp</strong></td>';
        EmailBodyText1+='<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;VAZI &nbsp; DO&nbsp;</strong></td>';
        EmailBodyText1+='<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MJESTO RADA &nbsp;&nbsp;</strong></td>';
        EmailBodyText1+='<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;  ROLA   &nbsp;&nbsp;&nbsp;</strong></td>';
        EmailBodyText1+='<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">Neposredni &nbsp; rukovodilac&nbsp</strong></td>';
        EmailBodyText1+='</tr>';


     ECL3.RESET;
     ECL3.SETFILTER("Show Record",'%1',TRUE);
     ECL3.SETFILTER("Position Description",'<>%1','');
     ECL3.SETFILTER("Starting Date",'<>%1',0D);
     //ECL3.SETFILTER("Reason for Change",'%1|%2|%3|%4|%5|%6|%7|%8|%9|%10',3,7,8,9,10,12,4,11,15,16);
     //ECL3.SETFILTER(Active,'%1',TRUE);
     ECL3.SETFILTER("Sent Mail Duration",'%1',FALSE);
     ECL3.SETFILTER("Sent Mail Change Pos",'%1',TRUE);
     ECL3.SETFILTER("Grounds for Term. Code",'%1','');
     ECL3.SETFILTER("Manner of Term. Code",'%1','');
      IF ECL3.FINDSET THEN REPEAT
         IF IsUpadate=FALSE THEN BEGIN
         REPORT.RUNMODAL(50050, FALSE, TRUE);
         IsUpadate:=TRUE;
         END;

         CLEAR(TextMsg);
         CLEAR(IStream);
         CLEAR(Mail);

      EMPCL1.RESET;
      EMPCL1.SETFILTER("Employee No.",ECL3."Employee No.");
     // EMPCL1.SETFILTER("Org. Structure",'%1',OrgC);
      //EMPCL1.SETFILTER("Starting Date",'<=%1',WORKDATE);
      //EMPCL1.SETFILTER(Active,'%1',TRUE);
       EMPCL1.SETFILTER("No.",'<>%1',ECL3."No.");
           EMPCL1.SETCURRENTKEY("Starting Date");
           EMPCL1.ASCENDING;

         IF EMPCL1.FINDLAST THEN BEGIN


       //  IF EMPCL1."No."=ECL3."No." THEN BEGIN
        // EMPCL1.NEXT(-1);
        // Found:=TRUE;

          IF EMPCL1."Team Description"<>'' THEN BEGIN
           OrgUnit:=EMPCL1."Sector Description"+'/'+ EMPCL1."Department Cat. Description"+'/'+ EMPCL1."Group Description"+'/'+EMPCL1."Team Description";
         END;
         IF (EMPCL1."Group Description"<>'') AND (EMPCL1."Team Description"='') THEN BEGIN

         OrgUnit:= EMPCL1."Sector Description"+'/'+ EMPCL1."Department Cat. Description"+'/'+EMPCL1."Group Description";
         END;
         IF  (EMPCL1."Group Description"='') AND (EMPCL1."Team Description"='') AND (EMPCL1."Department Cat. Description"<>'') THEN BEGIN
         OrgUnit:= EMPCL1."Sector Description"+'/'+EMPCL1."Department Cat. Description";
         END;
         IF (EMPCL1."Group Description"='') AND (EMPCL1."Team Description"='') AND (EMPCL1."Department Cat. Description"='') AND (EMPCL1."Sector Description"<>'') THEN BEGIN
           OrgUnit:= EMPCL1."Sector Description";
           END;
        EMPCL1.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
         EMPCL1.CALCFIELDS("Manager 2 First Name","Manager 2 Last Name");
       ManagerFull:=EMPCL1."Manager 1 First Name"+' '+EMPCL1."Manager 1 Last Name";
       IF EMPCL1."Manager 1 First Name"='' THEN
         ManagerFull:=EMPCL1."Manager 2 First Name"+' '+EMPCL1."Manager 2 Last Name";
       EndingDateOFPosition:=EMPCL1."Ending Date";
       EMPCL1.CALCFIELDS("Residence/Network");
       Reg:=FORMAT(EMPCL1."Regionalni Head Office");


         //  UNTIL (Found=TRUE) OR (EMPCL1.NEXT = 0);


     EMPCL1.CALCFIELDS("Residence/Network");
     "PositionPlace¸2":=EMPCL1."Position Description";

     Emp.SETFILTER("No.",'%1',EMPCL1."Employee No.");
       IF Emp.FINDFIRST THEN BEGIN
       Emp.CALCFIELDS("Role Code");
       Emp.CALCFIELDS("Role Name");
       END;
       IF EMPCL1."Org Unit Name"<>'' THEN
       MjestoRada:=EMPCL1."Org Unit Name";
     IF EMPCL1."GF of work Description"<>'' THEN
       MjestoRada:=EMPCL1."GF of work Description";


     PositionMenuOrginal.RESET;
     PositionMenuOrginal.SETFILTER(Code,'%1',EMPCL1."Position Code");
     PositionMenuOrginal.SETFILTER(Description,'%1',EMPCL1."Position Description");
     PositionMenuOrginal.SETFILTER("Org. Structure",'%1',EMPCL1."Org. Structure");
     IF PositionMenuOrginal.FINDFIRST THEN BEGIN
     RoleCode:=PositionMenuOrginal.Role;
     RoleName:=PositionMenuOrginal."Role Name";
     END;

         EmailBodyText1+= '<tr>';
       EmailBodyText1+=STRSUBSTNO('<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
       EmailBodyText1+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
       EmailBodyText1+=STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>', Emp."Employee ID");
       EmailBodyText1+=STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit+'/' + "PositionPlace¸2");
       EmailBodyText1+=STRSUBSTNO('<td style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>' ,FORMAT(EndingDateOFPosition,0,'<Day,2>.<Month,2>.<Year4>.'));
       EmailBodyText1+=STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>', MjestoRada+'/'+ EMPCL1."Phisical Department Desc");
       EmailBodyText1+=STRSUBSTNO('<td style="border-bottom:solid 1px black ;width:250px" ><span style="font-size: 10.0pt;">%1</td>',RoleCode+'-'+RoleName);
       EmailBodyText1+=STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
         EmailBodyText1+='</tr>';
            ECLCHange.RESET;
        ECLCHange.SETFILTER("Employee No.",'%1',ECL3."Employee No.");
        ECLCHange.SETFILTER("No.",'%1',ECL3."No.");
        IF ECLCHange.FINDFIRST THEN BEGIN
          ECLCHange."Sent Mail Duration":=TRUE;
          ECLCHange.MODIFY;
          END;
            END;
     UNTIL ECL3.NEXT=0;
       EmailBodyText1+='</table>';
           HRsetup.GET;
         SMTPMail.CreateMessage(HRsetup."Sender Name",HRsetup."E-mail Sender",HRsetup."E-mail Receiver",'Obavijest o trajanju rasporeda na trenutnoj poziciji',EmailBodyText1,TRUE);
        SMTPMail.Send();
       END;







         END;








     END;










     */

















        /*
        {*****************************************"Employment"*******************************************}
         IF ("Reason for Change"="Reason for Change"::"New Contract") AND ("Sent Mail Employment"=FALSE)AND ("Position Description"<>'') AND ("Starting Date"<>0D)
          THEN BEGIN
         EmailBodyText+='<p><span style="font-size: 12.0pt; font-family: "Tahoma">Po&scaron;tovani,';
         EmailBodyText+='<br /> <br /> Molim da poduzmete potrebne aktivnosti u vezi sa pocetkom rada/angazmana navedene osobe. ';
         EmailBodyText+='<br /> <br />';
         EmailBodyText += '<table border="?1" cellspacing="0" cellpadding="0" align="center"><span style="font-size: 10.0pt;">';
         EmailBodyText += '<tr><span style="font-size: 10.0pt;">';
         EmailBodyText+='<td bgcolor="#FFFFFF"><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
         EmailBodyText+=' <td bgcolor="#FFFFFF" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MATICNI BROJ&nbsp</strong> </td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> ORGANIZACIJSKA PRIPADNOST&nbsp</strong></td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;RADNO&nbsp; MJESTO&nbsp;</strong></td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;MJESTO&nbsp; RADA&nbsp;</strong></td>';;
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> VRSTA ANGAZMANA/PERSON TYPE/&nbsp</strong></td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">DATUM POCETKA RADA/ANGAZMANA&nbsp</strong> </td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;ROLA&nbsp;&nbsp;&nbsp;</strong></td>';
         EmailBodyText+='<td bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">Neposredni rukovodilac&nbsp</strong></td>';
         EmailBodyText+='</tr>';
        
          counter+=1;
          CLEAR(TextMsg);
          CLEAR(IStream);
          CLEAR(Mail);
        
        
            IF "Team Description"<>'' THEN BEGIN
               OrgUnit:="Sector Description"+'/'+ "Department Cat. Description"+'/'+ "Group Description"+'/'+"Team Description";
                  END;
            IF ("Group Description"<>'') AND ("Team Description"='') THEN BEGIN
                 OrgUnit:="Sector Description"+'/'+ "Department Cat. Description"+'/'+ "Group Description";
        
              END;
            IF ("Department Cat. Description"<>'') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
              OrgUnit:= "Sector Description"+'/'+ "Department Cat. Description";
        
              END;
              IF ("Sector Description"<>'') AND ("Department Cat. Description"='') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
                OrgUnit:="Sector Description";
        
                END;
            IF ("Sector Description"='') AND ("Department Cat. Description"='') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
              OrgUnit:='';
              END;
              PositionPlace:="Position Description";
              StartingDate:="Starting Date";
              CALCFIELDS("Residence/Network");
              CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
          ManagerFull:="Manager 1 First Name"+' '+"Manager 1 Last Name";
          Tip:='';
          Emp.SETFILTER("No.",'%1',"Employee No.");
          IF Emp.FINDFIRST THEN BEGIN
            Emp.CALCFIELDS("Role Code");
            Emp.CALCFIELDS("Role Name");
        
          IF Emp.Status=Status::Active THEN
            Tip:='Zaposlenik';
          END;
        
        
        EmailBodyText+= '<tr><span style="font-size: 10.0pt;">';
        
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',Emp."Employee ID");
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit);
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>' ,"Position Description");
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF" ><span style="font-size: 10.0pt;">%1</td>', "Phisical Department Desc");
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',Tip);
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', FORMAT(StartingDate,0,'<Day,2>.<Month,2>.<Year4>.'));
         EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',Emp."Role Code"+'-'+Emp."Role Name");
          EmailBodyText+=STRSUBSTNO('<td bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
          EmailBodyText += '</tr><span style="font-size: 10.0pt;">';
              EmailBodyText+='</table>';
           SMTPMail.CreateMessage('HR test','infodom.test@raiffeisengroup.ba','enisa.manjo@raiffeisengroup.ba','Obavijest o zaposljavanju/angazmanu',EmailBodyText,TRUE);
           SMTPMail.Send();
           "Sent Mail Employment":=TRUE;
            END;
        
        {*****************************************"CHANGE POSITION PLACE"*******************************************}
        
         IF (("Reason for Change"=3) OR ("Reason for Change"=7) OR ("Reason for Change"=8)
                                     OR ("Reason for Change"=9) OR ("Reason for Change"=10)
                                     OR ("Reason for Change"=12)) AND ("Sent Mail Change Pos"=FALSE) AND ("Position Description"<>'') AND ("Starting Date"<>0D)
          THEN BEGIN
        
           EmailBodyText+='<p><span style="font-size: 12.0pt; font-family: "Tahoma">Po&scaron;tovani,';
           EmailBodyText+='<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadleznosti u vezi sa pocetkom rada navedene osobe na novoj poziciji i/ili organizaciji.';
           EmailBodyText+='<br /> <br />';
           EmailBodyText += '<table border="1" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" align="center"><span style="font-size: 10.0pt;">';
           EmailBodyText += '<tr><span style="font-size: 10.0pt;">';
           EmailBodyText+='<td><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
           EmailBodyText+=' <td align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; JMBG &nbsp</strong> </td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;"> NOVI RASPORED&nbsp</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;VAZI&nbsp; ODASSA&nbsp;</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;MJESTO&nbsp; RADA&nbsp;</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;ROLA&nbsp;&nbsp;&nbsp;</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">Neposredni rukovodilac&nbsp</strong></td>';
           EmailBodyText+='</tr>';
        
          counter+=1;
          CLEAR(TextMsg);
          CLEAR(IStream);
          CLEAR(Mail);
        
          IF "Team Description"<>'' THEN BEGIN
            OrgUnit:="Sector Description"+'/'+ "Department Cat. Description"+'/'+ "Group Description"+'/'+"Team Description";
          END;
          IF ("Group Description"<>'') AND ("Team Description"='') THEN BEGIN
            OrgUnit:="Sector Description"+'/'+ "Department Cat. Description"+'/'+ "Group Description";
          END;
          IF ("Department Cat. Description"<>'') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
            OrgUnit:= "Sector Description"+'/'+ "Department Cat. Description";
          END;
          IF ("Sector Description"<>'') AND ("Department Cat. Description"='') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
            OrgUnit:=EmpCL."Sector Description"
          END;
          IF ("Sector Description"='') AND ("Department Cat. Description"='') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
            OrgUnit:='';
            WorkPlace:='';
          END;
          IF "Org Unit Name"<>'' THEN BEGIN
            WorkPlace:="Org Unit Name";
          END
          ELSE BEGIN
            WorkPlace:="GF of work Description";
          END;
        
          StartingDate:="Starting Date";
          CALCFIELDS("Residence/Network");
          CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
          ManagerFull:="Manager 1 First Name"+' '+"Manager 1 Last Name";
          Emp.SETFILTER("No.",'%1',"Employee No.");
        
          IF Emp.FINDFIRST THEN BEGIN
            Emp.CALCFIELDS("Role Code");
            Emp.CALCFIELDS("Role Name");
          END;
        
          EmailBodyText+= '<tr><span style="font-size: 10.0pt;">';
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',Emp."Employee ID");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit);
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',FORMAT(StartingDate,0,'<Day,2>.<Month,2>.<Year4>.'));
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', FORMAT("Residence/Network") +'/'+FORMAT("Regionalni Head Office"));
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',Emp."Role Code"+'-'+Emp."Role Name");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
          EmailBodyText += '</tr><span style="font-size: 10.0pt;">';
        
              EmailBodyText+='</table>';
                SMTPMail.CreateMessage('HR test','infodom.test@raiffeisengroup.ba','infodom.test@raiffeisengroup.ba','Obavijest o pocetku rada na novoj poziciji',EmailBodyText,TRUE);
           SMTPMail.Send();
         "Sent Mail Change Pos":=TRUE;
            END;
        
         {**********************************************TERMINATION************************************************}
        
        
        IF ("Grounds for Term. Code"<>'') AND ("Sent Mail Termination"=FALSE) AND ("Position Description"<>'') AND ("Starting Date"<>0D)  THEN BEGIN
        
            EmailBodyText+='<p><span style="font-size: 12.0pt; font-family: "Tahoma">Po&scaron;tovani,';
            EmailBodyText+='<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadleznosti u vezi sa prestankom rada/angazmana navedene osobe. ';
            EmailBodyText+='<br /> <br />';
            EmailBodyText += '<table border="1"  bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" align="center"><span style="font-size: 10.0pt;">';
            EmailBodyText += '<tr><span style="font-size: 10.0pt;">';
            EmailBodyText+='<td><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
            EmailBodyText+=' <td align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; JMBG &nbsp</strong> </td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;"> ORGANIZACIONA PRIPADNOST&nbsp</strong></td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;RADNO&nbsp; MJESTO&nbsp;</strong></td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;ZADNJI RADNI DAN&nbsp;&nbsp;</strong></td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">VRSTA ANGAZMANA/PERSON TYPE/&nbsp</strong></td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;ROLA&nbsp;&nbsp;&nbsp;</strong></td>';
            EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">Neposredni rukovodilac&nbsp</strong></td>';
            EmailBodyText+='</tr>';
        
            counter+=1;
            CLEAR(TextMsg);
            CLEAR(IStream);
            CLEAR(Mail);
        
            IF "Team Description"<>'' THEN BEGIN
               OrgUnit:="Sector Description"+'/'+ "Department Cat. Description"+'/'+ "Group Description"+'/'+"Team Description";
            END;
            IF ("Group Description"<>'') AND ("Team Description"='') THEN BEGIN
                 OrgUnit:="Sector Description"+'/'+ "Department Cat. Description"+'/'+ "Group Description";
              END;
            IF ("Department Cat. Description"<>'') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
              OrgUnit:= "Sector Description"+'/'+ "Department Cat. Description";
              END;
              IF ("Sector Description"<>'') AND ("Department Cat. Description"='') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
                OrgUnit:="Sector Description"
                END;
            IF ("Sector Description"='') AND ("Department Cat. Description"='') AND ("Group Description"='') AND ("Team Description"='') THEN BEGIN
              OrgUnit:='';
              END;
        
           PositionPlace:="Position Description";
           Tip:='';
         CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
          ManagerFull:="Manager 1 First Name"+' '+"Manager 1 Last Name";
          Emp.SETFILTER("No.",'%1',EmpCL."Employee No.");
          IF Emp.FINDFIRST THEN BEGIN
          Emp.CALCFIELDS("Role Code");
          Emp.CALCFIELDS("Role Name");
          IF ((Emp.Status=Emp.Status::Active) OR (Emp.Status=Emp.Status::Terminated)) THEN Tip:='Zaposlenik';
          END;
        
         EmailBodyText+= '<tr><span style="font-size: 10.0pt;">';
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',Emp."Employee ID");
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit);
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>' ,PositionPlace);
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', FORMAT(EmpCL."Ending Date",0,'<Day,2>.<Month,2>.<Year4>.'));
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Tip);
         EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',Emp."Role Code"+'-'+Emp."Role Name");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',EmpCL."Manager 1 First Name"+' '+EmpCL."Manager 1 Last Name");
          EmailBodyText += '</tr><span style="font-size: 10.0pt;">';
        
            SMTPMail.CreateMessage('HR test','infodom.test@raiffeisengroup.ba','infodom.test@raiffeisengroup.ba','Obavjest o prestanku radnog odnosa/angazmana',EmailBodyText,TRUE);
           SMTPMail.Send();
           "Sent Mail Termination":=TRUE;
            END;
             {**********************************************DURATION************************************************}
        
        IF ("Reason for Change"="Reason for Change"::"New Contract") AND (Status=Status::Active) AND ("Ending Date"=0D) AND ("Sent Mail Duration"=FALSE) AND ("Sent Mail Change Pos"=TRUE) AND ("Position Description"<>'') AND ("Starting Date"<>0D) THEN BEGIN
           EmailBodyText+='<p><span style="font-size: 10.0pt; font-family: "Tahoma">Po&scaron;tovani,';
           EmailBodyText+='<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadleznosti, u vezi sa izmjenom trenutnog rasporeda koji vazi do datuma kako je navedeno u tabeli';
           EmailBodyText+='<br /> <br />';
           EmailBodyText += '<table border="1"  bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" align="center"><span style="font-size: 10.0pt;">';
           EmailBodyText += '<tr><span style="font-size: 10.0pt;">';
           EmailBodyText+='<td><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
           EmailBodyText+=' <td align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; JMBG &nbsp</strong> </td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;"> STARI RASPORED&nbsp</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;VAZI DO&nbsp;</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;MJESTO RADA&nbsp;&nbsp;</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;ROLA&nbsp;&nbsp;&nbsp;</strong></td>';
           EmailBodyText+='<td align="center" ><strong><span style="font-size: 10.0pt;">Neposredni rukovodilac&nbsp</strong></td>';
           EmailBodyText+='</tr>';
        
            counter+=1;
            CLEAR(TextMsg);
            CLEAR(IStream);
            CLEAR(Mail);
              EMPCL1.SETFILTER("Employee No.",Rec."Employee No.");
            IF EMPCL1.FINDSET THEN
            REPEAT
            Found:=FALSE;
            IF EMPCL1."No."=Rec."No." THEN BEGIN
            EMPCL1.NEXT(-1);
            Found:=TRUE;
             IF EMPCL1."Team Description"<>'' THEN BEGIN
              OrgUnit:=EMPCL1."Sector Description"+'/'+ EMPCL1."Department Cat. Description"+'/'+ EMPCL1."Group Description"+'/'+EMPCL1."Team Description";
            END;
            IF (EMPCL1."Group Description"<>'') AND (EMPCL1."Team Description"='') THEN BEGIN
        
            OrgUnit:= EMPCL1."Sector Description"+'/'+ EMPCL1."Department Cat. Description"+'/'+EMPCL1."Group Description";
            END;
            IF  (EMPCL1."Group Description"='') AND (EMPCL1."Team Description"='') AND (EMPCL1."Department Cat. Description"<>'') THEN BEGIN
            OrgUnit:= EMPCL1."Sector Description"+'/'+EMPCL1."Department Cat. Description";
            END;
            IF (EMPCL1."Group Description"='') AND (EMPCL1."Team Description"='') AND (EMPCL1."Department Cat. Description"='') AND (EMPCL1."Sector Description"<>'') THEN BEGIN
              OrgUnit:= EMPCL1."Sector Description";
              END;
           EMPCL1.CALCFIELDS("Manager 1 First Name","Manager 1 Last Name");
          ManagerFull:=EMPCL1."Manager 1 First Name"+' '+EMPCL1."Manager 1 Last Name";
          EndingDateOFPosition:=EMPCL1."Ending Date";
          EMPCL1.CALCFIELDS("Residence/Network");
          Reg:=FORMAT(EMPCL1."Regionalni Head Office");
        
              END;
              UNTIL (Found=TRUE) OR (EMPCL1.NEXT = 0);
        
        EMPCL1.CALCFIELDS("Residence/Network");
        
        Emp.SETFILTER("No.",'%1',Rec."Employee No.");
          IF Emp.FINDFIRST THEN BEGIN
          Emp.CALCFIELDS("Role Code");
          Emp.CALCFIELDS("Role Name");
          END;
        
          EmailBodyText+= '<tr><span style="font-size: 10.0pt;">';
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."First Name"+' '+Emp."Last Name");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', Emp."Employee ID");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>' ,OrgUnit);
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>' ,FORMAT(EndingDateOFPosition,0,'<Day,2>.<Month,2>.<Year4>.'));
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>', FORMAT(EMPCL1."Residence/Network") +'/'+Reg);
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',Emp."Role Code"+'-'+Emp."Role Name");
          EmailBodyText+=STRSUBSTNO('<td><span style="font-size: 10.0pt;">%1</td>',ManagerFull);
          EmailBodyText += '</tr><span style="font-size: 10.0pt;">';
          EmailBodyText+='</table>';
        
          SMTPMail.CreateMessage('HR test','infodom.test@raiffeisengroup.ba','infodom.test@raiffeisengroup.ba','Obavijest o trajanju rasporeda na trenutnoj poziciji',EmailBodyText,TRUE);
          SMTPMail.Send();
          "Sent Mail Duration":=TRUE;
          END;
          */
        //CurrPage.UPDATE;



    end;

    var
        show: Boolean;
        UserPersonalization: Record "User Personalization";
        Tip: Text;
        EditableNetto: Boolean;
        EditableBrutto: Boolean;
        CloseDate: Date;
        ECLCD: Record "Employee Contract Ledger";
        ECLCopy: Record "Employee Contract Ledger";
        ECLCopy2: Record "Employee Contract Ledger";
        Sec: Record "Sector";
        NemaNiko: Boolean;
        Org: Record "Org Dijelovi";
        OrgDijelovi: Record "Org Dijelovi";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        ContractPhase: Record "Contract Phase t";
        ContractPhasePage: Page "Contract Phase";
        IsVisible: Boolean;
        UserPersonalisation: Record "User Personalization";
        DR: Record "Document Register";
        ReportLayoutSelection: Record "Report Layout Selection";
        CRL: Record "Custom Report Layout";
        PayRange: Record "Payment range";
        BruttoError: Label 'Brutto isn''t in pay range!';
        // ContractR: Report "test";
        //  ContractP: Report "Anex Contract -r";
        Text000: Label 'Would you like to save the changes?';
        lcduMail: Codeunit "SMTP Mail";
        HRsetup: Record "Human Resources Setup";
        ReportDistributionManagement: Codeunit "Report Distribution Management";
        DocumentSendingProfile: Record "Document Sending Profile";
        // R: Report "Segmentation report";
        DocumentMailing: Codeunit "Document-Mailing";
        CustomReportSelection: Record "Custom Report Selection";
        R_PayList: Report "Pay List";
        FileManagement: Codeunit "File Management";
        filename: Text;
        n: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "Mail";
        TM: Record "Template Messages";
        TextMsg: BigText;
        IStream: InStream;
        counter: Integer;
        MessageBody: Text;
        EmpName: Text;
        Emp1: Record "Employee";
        Manager1: Text;
        Manager2: Text;
        Manager3: Text;
        Emp2: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        attachment1: Text;
        SMTPMail: Codeunit "SMTP Mail";
        Pos: Record "Position";
        attachment2: Text;
        AttFiles: array[5] of Text;
        CC: Text;
        CompanyInfo: Record "Company Information";
        TempBlob: Codeunit "Temp Blob";
        FileManagment: Codeunit "File Management";
        LastFieldNo: Integer;
        ConfidentialInformationFilter: Text;
        OD: Codeunit "Temp Blob";
        PhaseR: Option;
        OD2: Codeunit "Temp Blob";
        DatumOd: Date;
        EmpCL: Record "Employee Contract Ledger";
        OrgUnit: Text;
        PositionPlace: Text;
        WorkPlace: Text;
        StartingDate: Date;
        EmployeeRole: Code[10];
        ManagerC: Text;
        ManagerFull: Text;
        ES: Record "Employee Surname";
        OldCompanyEmail: Text;
        NewCompanyEmail: Text;
        EndingDate: Date;
        EMPCL1: Record "Employee Contract Ledger";
        Found: Boolean;
        NoPrevious: Integer;
        EndingDateOFPosition: Date;
        EmailBodyText: Text;
        Emp: Record "Employee";
        Reg: Text;
        Brojac: Integer;
        filenamenew: Text;
        DR1: Record "Document Register";
        ReportLayoutSelection1: Record "Report Layout Selection";
        CRL1: Record "Custom Report Layout";
        CRL2: Record "Custom Report Layout";
        //ĐK Certificatematernity: Report "Certificate for maternity leav";
        PosNew: Record "Position";
        Employee: Record "Employee";
        ECLTable: Record "Employee Contract Ledger";
        tempSaveDest: Text;
        tempFile: File;
        NewStream: InStream;
        ToFile: Text;
        ReturnValue: Boolean;
        Attachment: Record "Attachment";
        BrojUgovora: Integer;
        PositionMenu: Record "Position Menu";
        DepartmentT: Record "Department";
        DepartmentT1: Record "Department";
        PositionBenefits: Record "Position Benefits";
        PositionBenefits1: Record "Position Benefits";
        OsActive: Record "ORG Shema";
        Role: Record "Role";
        pOSITIONTA: Record "Position";
        pOSITIONTA1: Record "Position";
        Misc: Record "Misc. Article Information";
        // RefreshOrg: Report "Org unit refresh 2";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        DimensionForPosition: Record "Dimension for position";
        UserT: Record "User";
        //ĐK ObrazacJS3100: Report "Obrazac JS3100";
        //ĐK   ObrazacPD300: Report "Obrazac PD3100";
        OrgF: Record "ORG Shema";
        OrgC: Code[10];
        ECL1: Record "Employee Contract Ledger";
        MjestoRada: Text;
        PositionMenuOrginal: Record "Position Menu";
        RoleCode: Code[10];
        RoleName: Text;
        ECL2: Record "Employee Contract Ledger";
        EmailBodyText1: Text;
        EmailBodyText2: Text;
        ECL3: Record "Employee Contract Ledger";
        ECL4: Record "Employee Contract Ledger";
        ECL5: Record "Employee Contract Ledger";
        "PositionPlace¸2": Text;
        ECLCHange: Record "Employee Contract Ledger";
        EmailBodyText5: Text;
        Dep: Record "Department";
        PositionRec: Record "Position Menu";
        Izmjena: Boolean;
        FilterEmployeeNo: Code[10];
        ECLLastDate: Record "Employee Contract Ledger";
        IsUpadate: Boolean;
}

