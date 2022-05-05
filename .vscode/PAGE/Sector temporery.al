table 50250 "Sector temporary"
{
    Caption = 'Sector';
    DrillDownPageID = "Sector temporary sist";
    LookupPageID = "Sector temporary sist";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                /*IF Code <> xRec.Code THEN BEGIN
                  HumanResSetup.GET;
                  NoSeriesMgt.TestManual(HumanResSetup."B-1 Nos.");
                  "No. Series" := '';
                END;*/
                //EVALUATE(Order,Code);
                /*Dep.SETFILTER(Code,'%1',xRec.Code);
                Dep.SETFILTER("ORG Shema",'%1',"Org Shema");
                IF Dep.FINDSET THEN REPEAT
                  IF Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description",xRec.Description)
                    THEN
                    Dep.RENAME(Rec.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description",Rec.Description)
                      UNTIL Dep.NEXT=0;*/

                OsPreparation.RESET;
                OsPreparation.SETFILTER(Status, '%1', 2);
                IF OsPreparation.FINDLAST THEN BEGIN
                    "Org Shema" := OsPreparation.Code;
                END
                ELSE BEGIN
                    "Org Shema" := '';
                END;
                "Department Type" := 8;
                IF Rec.Code <> '' THEN BEGIN
                    IF Rec.Description = '' THEN BEGIN
                        DepartmentTemp.INIT;
                        DepartmentTemp.Sector := Rec.Code;
                        DepartmentTemp.VALIDATE(Code, Rec.Code);
                        DepartmentTemp.INSERT;
                    END
                    ELSE BEGIN
                        DepartmentTemp.SETFILTER(Code, '%1', xRec.Code);
                        DepartmentTemp.SETFILTER(Description, '%1', Rec.Description);
                        IF DepartmentTemp.FINDFIRST THEN BEGIN
                            IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", '', '', '', DepartmentTemp.Description) THEN
                                DepartmentTemp1.RENAME(Rec.Code, "Org Shema", '', '', '', xRec.Description);
                        END;
                    END;
                END;

            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin

                OsPreparation.RESET;
                OsPreparation.SETFILTER(Status, '%1', 2);
                IF OsPreparation.FINDLAST THEN BEGIN
                    "Org Shema" := OsPreparation.Code;
                END
                ELSE BEGIN
                    "Org Shema" := '';
                END;
                "Department Type" := 8;
                /* IF Rec.Description<>'' THEN BEGIN
                   DepartmentTemp.SETFILTER(Sector,'%1',Rec.Code);
                   DepartmentTemp.SETFILTER("Sector  Description",'%1',Rec.Description);



                             IF Rec.Code<>'' THEN BEGIN
                 DepartmentTemp.SETFILTER(Sector,'%1',Rec.Code);
                 DepartmentTemp.SETFILTER("Department Type",'%1',8);
                 DepartmentTemp.SETFILTER("Sector  Description",'%1',Rec.Description);
                      IF DepartmentTemp.FIND('-') THEN BEGIN
                 IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'','','',DepartmentTemp.Description) THEN
                 DepartmentTemp1.RENAME(Code,"Org Shema",'','','',Description);
                 DepartmentTemp1.Sector:=Code;
                 DepartmentTemp1."Sector  Description":=Description;
                 DepartmentTemp1.MODIFY;

                           END
                 ELSE BEGIN
                 DepartmentTemp.INIT;
                 DepartmentTemp.Description:=Description;
                 DepartmentTemp.Sector:=Code;
                 DepartmentTemp."Sector  Description":=Description;
                 DepartmentTemp.INSERT;
                 END;
              END;
           END;*/
                IF Rec.Description <> '' THEN BEGIN
                    DepartmentTemp.SETFILTER("Department Type", '%1', 8);
                    DepartmentTemp.SETFILTER(Sector, '%1', Rec.Code);
                    IF DepartmentTemp.FINDFIRST THEN BEGIN
                        IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", '', '', '', DepartmentTemp.Description) THEN
                            DepartmentTemp1.RENAME(Rec.Code, "Org Shema", '', '', '', Rec.Description);
                        DepartmentTemp1."Sector  Description" := Rec.Description;
                        DepartmentTemp1.Sector := Rec.Code;
                        DepartmentTemp1.MODIFY;

                    END;

                END;

            end;
        }
        field(50000; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50001; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50002; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50004; "Changing Department"; Boolean)
        {
            Caption = 'Changing Department';

            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
                    END;*/

            end;
        }
        field(50005; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50006; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50007; Identity; Integer)
        {
            AutoIncrement = true;
            Caption = 'Identity';
        }
        field(50008; "Number Of Dep Cat levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE(Sector = FIELD("Code"),
                                                              "Department Type" = FILTER(4),
                                                              "Sector  Description" = FIELD(Description)));
            Caption = 'Number Of Department Categroy levels below';

        }
        field(50011; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension temporary"."Dimension Value Code" WHERE(Code = FIELD(Code));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                IF "Dimension Value Code" <> '' THEN BEGIN
                    DimensionNew.SETFILTER("Dimension Value Code", '%1', Rec."Dimension Value Code");
                    IF DimensionNew.FINDFIRST THEN BEGIN
                        DimensionNew.CALCFIELDS("Dimension  Name");
                        "Dimension  Name" := DimensionNew."Dimension  Name";
                    END;
                END
                ELSE BEGIN
                    "Dimension  Name" := '';
                END;

            end;
        }
        field(50012; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(50013; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temporary" WHERE("Code" = FIELD("Code"),
                                                             Description = FIELD(Description),
                                                             "Department Type" = FIELD("Department Type"),
                                                             "ORG Shema" = FIELD("Org Shema")));
            Caption = 'Number of dimension value';

        }
        field(50014; "Number Of Group levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE(Sector = FIELD("Code"),
                                                              "Department Type" = FILTER("Group"),
                                                              "Sector  Description" = FIELD(Description)));
            Caption = 'Number Of Group levels below';

        }
        field(50015; "Number Of Team  levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE(Sector = FIELD("Code"),
                                                              "Department Type" = FILTER(Team),
                                                              "Sector  Description" = FIELD(Description)));
            Caption = 'Number Of Team  levels below';

        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                IF FORMAT(Rec."Residence/Network") <> '' THEN BEGIN
                    IF Code <> '' THEN BEGIN
                        IF Description <> '' THEN BEGIN

                            DepartmentTemp.RESET;
                            DepartmentTemp.SETFILTER(Code, '%1', Code);
                            DepartmentTemp.SETFILTER(Description, '%1', Description);
                            DepartmentTemp.SETFILTER("Department Type", '%1', 8);
                            IF DepartmentTemp.FINDFIRST THEN BEGIN
                                DepartmentTemp."Residence/Network" := "Residence/Network";
                                DepartmentTemp.MODIFY;
                            END;

                        END;
                    END;
                END;
            end;
        }
        field(50017; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;
        }
        field(50018; LastModified; Text[250])
        {
            Caption = 'Last modified code';
        }
        field(50019; "Name of TC"; Text[250])
        {
            Caption = 'Name of TC';
            FieldClass = Normal;
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translate of Sector"; Text[250])
        {
            Caption = 'Official Translate of Sector';
        }
        field(500403; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
        }
        field(500404; Ispis; Boolean)
        {
        }
        field(500405; Parent; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Org Shema", Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code", "Org Shema")
        {
        }
    }

    trigger OnDelete()
    begin
        /*
        ShopCalendarWorkDays.SETRANGE(Code,Code);
        ShopCalendarWorkDays.DELETEALL;
        
        ShopCalHoliday.SETRANGE(Code,Code);
        ShopCalHoliday.DELETEALL;
        */
        IF Rec."Department Type" = 8 THEN BEGIN
            SectorTempBelong.RESET;
            SectorTempBelong.SETFILTER(Description, '%1', Rec.Description);
            IF SectorTempBelong.FINDFIRST THEN BEGIN
                SectorTempBelong.CALCFIELDS("Number of dimension value");
                IF SectorTempBelong."Number of dimension value" = 2 THEN BEGIN
                    DimensionTempYes.RESET;
                    DimensionTempYes.SETFILTER("Sector  Description", '%1', Rec.Description);
                    IF DimensionTempYes.FINDFIRST THEN BEGIN
                        SectorTempBelong."Name of TC" := DimensionTempYes."Dimension Value Code" + ' ' + '-' + ' ' + DimensionTempYes."Dimension  Name";
                        SectorTempBelong.MODIFY;
                    END
                    ELSE BEGIN
                        SectorTempBelong."Name of TC" := '';
                        SectorTempBelong.MODIFY;
                    END;
                END;
            END;
        END;

    end;

    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("B-1 Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."B-1 Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;

        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        OsPreparation.RESET;
        OsPreparation.SETFILTER(Status, '%1', 2);
        IF OsPreparation.FINDLAST THEN BEGIN
            "Org Shema" := OsPreparation.Code;
        END
        ELSE BEGIN
            "Org Shema" := '';
        END;
        "Department Type" := 8;
        DepartmentTemp.RESET;
        DepartmentTemp.SETFILTER(Sector, '%1', Rec.Code);
        DepartmentTemp.SETFILTER("Sector  Description", '%1', Rec.Description);
        DepartmentTemp.SETFILTER("Department Type", '%1', 8);
        IF DepartmentTemp.FINDFIRST THEN BEGIN
            DepartmentTemp."Sector Identity" := Rec.Identity;
            DepartmentTemp.MODIFY;
        END;

        SectorInsertModify.RESET;
        SectorInsertModify.SETFILTER(Code, '<>%1', Rec.Code);
        IF SectorInsertModify.FINDSET THEN
            REPEAT
                SectorInsertModify.LastModified := '';
                SectorInsertModify.LastModified := FORMAT(Rec.Code) + ' ' + Rec.Description;
                SectorInsertModify.MODIFY;
            UNTIL SectorInsertModify.NEXT = 0;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        ShopCalendarWorkDays: Record "Department Category";
        ShopCalHoliday: Record "Group";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        DepartmentChange: Report "Department Temporary change";
        DimensionNew: Record "Dimension temporary";
        DepartmentTemp: Record "Department temporary";
        OsPreparation: Record "ORG Shema";
        DepartmentTemp1: Record "Department temporary";
        Sec: Record "Sector temporary";
        DA: Integer;
        SectorInsertModify: Record "Sector temporary";
        SectorTempBelong: Record "Sector temporary";
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong1: Record "Sector temporary";
        DimensionTempYes: Record "Dimension temporary";
}

