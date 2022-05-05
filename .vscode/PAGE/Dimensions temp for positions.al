page 50086 "Dimensions temp for positions"
{
    Caption = 'Dimensions temporary';
    PageType = List;
    SourceTable = "Dimension temp for position";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Org Belongs"; "Org Belongs")
                {
                    TableRelation = "Department temporary".Description;
                    ApplicationArea = all;
                }

                field("Dimension  Name"; "Dimension  Name")
                {
                    ApplicationArea = all;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = all;
                }
                field(Belongs; Belongs)
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin




        /* IF Rec."Department Type"=8 THEN BEGIN
         Rec.FILTERGROUP(2);
        Rec.SETRANGE("Department Type",8);
        Rec.SETRANGE(Code,Rec.Code);
        Rec.SETRANGE(Description,'%1',Rec.Description);
        Rec.FILTERGROUP(0);
        END;


         IF Rec."Department Type"=4 THEN BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Department Type",4);
        Rec.SETRANGE("Department Category",Rec."Department Category");
        Rec.SETRANGE("Department Categ.  Description",Rec."Department Categ.  Description");
        Rec.FILTERGROUP(0);
        END;


        IF Rec."Department Type"=2 THEN BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Department Type",2);
        Rec.SETRANGE("Group Code",Rec."Group Code");
        Rec.SETRANGE("Group Description",Rec."Group Description");
        Rec.FILTERGROUP(0);
        END;

        IF Rec."Department Type"=9 THEN BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Department Type",9);
        Rec.SETRANGE("Team Code",Rec."Team Code");
        Rec.SETRANGE("Team Description",Rec."Team Description");
        Rec.FILTERGROUP(0);
        END;*/

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        PositionMenuCorrect.RESET;
        PositionMenuCorrect.SETFILTER(Code, '%1', Rec."Position Code");
        PositionMenuCorrect.SETFILTER(Description, '%1', Rec."Position Description");
        IF PositionMenuCorrect.FINDFIRST THEN BEGIN
            IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code, PositionMenuCorrect.Description, PositionMenuCorrect."Department Code", PositionMenuCorrect."Org. Structure") THEN BEGIN
                PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code, PositionMenuCorrect.Description, '', PositionMenuCorrect."Org. Structure");
                //Code,Description,Department Code,Org. Structure
            END;

        END;
    end;

    trigger OnOpenPage()
    begin
        DimensionForPos.RESET;
        DimensionForPos.SETFILTER(Sector, '<>%1', '');
        IF DimensionForPos.FINDSET THEN
            REPEAT
                SectorReal.RESET;
                SectorReal.SETFILTER(Description, '%1', DimensionForPos."Sector  Description");
                IF SectorReal.FINDFIRST THEN BEGIN
                    DimensionForPos1 := DimensionForPos;
                    DimensionForPos1."Sector Identity" := SectorReal.Identity;
                    DimensionForPos1.MODIFY;
                END;
            UNTIL DimensionForPos.NEXT = 0;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        /* PositionMenuCorrect.RESET;
         PositionMenuCorrect.SETFILTER(Code,'%1',Rec."Position Code");
         PositionMenuCorrect.SETFILTER(Description,'%1',Rec."Position Description");
         IF PositionMenuCorrect.FINDFIRST THEN BEGIN
           IF Rec."Team Description"<>'' THEN BEGIN
            IF  PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
              PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,Rec."Team Code",PositionMenuCorrect."Org. Structure");
       //Code,Description,Department Code,Org. Structure
       END;
         END;
         IF (Rec."Group Description"<>'') AND (Rec."Team Description"='') THEN BEGIN
            IF  PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
              PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,Rec."Group Code",PositionMenuCorrect."Org. Structure");
       //Code,Description,Department Code,Org. Structure
       END;
         END;
         IF (Rec."Department Categ.  Description"<>'') AND (Rec."Group Description"='') THEN BEGIN
            IF  PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
              PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,Rec."Department Category",PositionMenuCorrect."Org. Structure");
       //Code,Description,Department Code,Org. Structure
       END;
         END;
         IF (Rec."Sector  Description"<>'') AND (Rec."Department Categ.  Description"='') THEN BEGIN
            IF  PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
              PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,Rec.Sector,PositionMenuCorrect."Org. Structure");
       //Code,Description,Department Code,Org. Structure
       END;
         END;
          END;*/

    end;

    var
        /* CM: Record "99000772";
         CMPage: Page "99000769";
         Compensation: Record "99000799";
         CompensationPage: Page "99000794";
         ContractPhase: Record "Position Benefits temporery";
         */
        ECL: Record "Employee Contract Ledger";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        // Tip: Record "Type";
        Dep: Record "Department temporary";
        DC: Record "Department Category temporary";
        TEAM: Record "Team temporary";
        GR: Record "Group temporary";
        SectorR: Record "Sector temporary";
        NewDepartment: Record "Department temporary";
        DepartmentCategory: Record "Department Category temporary";
        SectorNew: Record "Sector temporary";
        GroupNew: Record "Group temporary";
        Team1: Record "Team temporary";
        DepartmentCheck: Record "Department temporary";
        DepartmentValidate: Record "Department temporary";
        OrgStr: Record "ORG Shema";
        Sec: Record "Sector temporary";
        DepCat: Record "Department Category temporary";
        Dimension: Record "Dimension temporary";
        DepartmentTempTry: Record "Department temporary";
        DepartmentTempTry1: Record "Department temporary";
        DimensionNewTemp: Record "Dimension temporary";
        Found: Boolean;
        SectorTemp: Record "Sector temporary";
        Broj: Integer;
        Dimensiontemp: Record "Dimension temporary";
        SectorReal: Record "Sector temporary";
        DimensionForPos: Record "Dimension temp for position";
        DimensionForPos1: Record "Dimension temp for position";
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
}

