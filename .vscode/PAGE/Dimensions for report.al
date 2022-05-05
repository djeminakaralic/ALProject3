page 50138 "Dimensions for report"
{
    Caption = 'Dimensions temporary';
    PageType = ListPart;
    SourceTable = "Dimension for report";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //ĐK  CurrPage.UPDATE;

                    end;
                }
                field("Dimension  Name"; "Dimension  Name")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;

                    end;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*
          IF Rec."Department Type"=8 THEN BEGIN
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
         END;
         */

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        /*IF Rec."Department Type"=8 THEN BEGIN
        SectorTempBelong.RESET;
          SectorTempBelong.SETFILTER(Description,'%1',Rec.Description);
          IF SectorTempBelong.FINDFIRST THEN BEGIN
            SectorTempBelong.CALCFIELDS("Number of dimension value");
            IF SectorTempBelong."Number of dimension value"=2 THEN BEGIN
              DimensionTempYes.RESET;
              DimensionTempYes.SETFILTER("Sector  Description",'%1',Rec."Sector  Description");
              IF DimensionTempYes.FINDFIRST THEN BEGIN
                SectorTempBelong."Name of TC":=DimensionTempYes."Dimension Value Code"+' '+'-'+' '+DimensionTempYes."Dimension  Name";
              SectorTempBelong.MODIFY;
              END
              ELSE BEGIN
                SectorTempBelong."Name of TC":='';
              SectorTempBelong.MODIFY;
              END;
               END;
                 END;
                   END;*/

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        /*SectorTempBelong.RESET;
        SectorTempBelong.SETFILTER(Code,'<>%1','');
        IF SectorTempBelong.FINDSET THEN REPEAT
           SectorTempBelong.CALCFIELDS("Number of dimension value");
           IF SectorTempBelong."Number of dimension value"=1  THEN BEGIN
            SectorTempBelong1:=SectorTempBelong;
            DimensionsTempTabela.RESET;
            DimensionsTempTabela.SETFILTER("Department Type",'%1',8);
            DimensionsTempTabela.SETFILTER("Sector  Description",'%1',SectorTempBelong.Description);
            DimensionsTempTabela.SETFILTER("ORG Shema",'%1',SectorTempBelong."Org Shema");
            IF DimensionsTempTabela.FINDSET THEN BEGIN
              IF DimensionsTempTabela.COUNT=1 THEN BEGIN
            SectorTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
              SectorTempBelong1.MODIFY;
              END;
                END;
                  END;
        
                   UNTIL SectorTempBelong.NEXT=0;
                */

        /*
         DepTempBelong.RESET;
         DimensionsTempTabela.RESET;
        DepTempBelong.SETFILTER(Code,'<>%1','');
        IF DepTempBelong.FINDSET THEN REPEAT
           DepTempBelong.CALCFIELDS("Number of dimension value");
           IF DepTempBelong."Number of dimension value"=1  THEN BEGIN
            DepTempBelong1:=DepTempBelong;
            DimensionsTempTabela.RESET;
            DimensionsTempTabela.SETFILTER("Department Type",'%1',4);
            DimensionsTempTabela.SETFILTER("Department Categ.  Description",'%1',DepTempBelong.Description);
            IF DimensionsTempTabela.FINDFIRST THEN BEGIN
            DepTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
              DepTempBelong1.MODIFY;
              END;
        
                END;
          UNTIL DepTempBelong.NEXT=0;
          GroupTempBelong.RESET;
          DimensionsTempTabela.RESET;
        GroupTempBelong.SETFILTER(Code,'<>%1','');
        IF GroupTempBelong.FINDSET THEN REPEAT
           GroupTempBelong.CALCFIELDS("Number of dimension value");
           IF GroupTempBelong."Number of dimension value"=1  THEN BEGIN
            GroupTempBelong1:=GroupTempBelong;
            DimensionsTempTabela.RESET;
            DimensionsTempTabela.SETFILTER("Department Type",'%1',2);
            DimensionsTempTabela.SETFILTER("Group Description",'%1',GroupTempBelong.Description);
            IF DimensionsTempTabela.FINDFIRST THEN BEGIN
            GroupTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
              GroupTempBelong1.MODIFY;
              END;
                END;
          UNTIL GroupTempBelong.NEXT=0;
          TeamTempBelong.RESET;
          DimensionsTempTabela.RESET;
        TeamTempBelong.SETFILTER(Code,'<>%1','');
        IF TeamTempBelong.FINDSET THEN REPEAT
           TeamTempBelong.CALCFIELDS("Number of dimension value");
           IF TeamTempBelong."Number of dimension value"=1  THEN BEGIN
            TeamTempBelong1:=TeamTempBelong;
            DimensionsTempTabela.RESET;
            DimensionsTempTabela.SETFILTER("Department Type",'%1',9);
            DimensionsTempTabela.SETFILTER("Team Description",'%1',TeamTempBelong.Name);
            IF DimensionsTempTabela.FINDFIRST THEN BEGIN
            TeamTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
             TeamTempBelong1.MODIFY;
              END;
                END;
          UNTIL TeamTempBelong.NEXT=0;*/

    end;

    var
        /*CM: Record "99000772";
        CMPage: Page "99000769";
        Compensation: Record "99000799";
        CompensationPage: Page "99000794";*/
        ContractPhase: Record "Contract Phase t";
        ECL: Record "Employee Contract Ledger";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        //ĐK Tip: Record "Type";
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
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong: Record "Sector temporary";
        SectorTempBelong1: Record "Sector temporary";
        DepTempBelong: Record "Department Category temporary";
        DepTempBelong1: Record "Department Category temporary";
        TeamTempBelong: Record "Team temporary";
        TeamTempBelong1: Record "Team temporary";
        GroupTempBelong: Record "Group temporary";
        GroupTempBelong1: Record "Group temporary";
        SectorTempPage: Page "Sector temporary sist";
        DimensionTempYes: Record "Dimension temporary";
        OutReport: Boolean;
        DepartmentTchangesector: Report "Department T change sector";
        oRG: Code[10];
        CODEBack: Code[10];
        descBack: Text;
}

