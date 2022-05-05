table 50139 "Department Category temporary"
{
    Caption = 'Department';
    DrillDownPageID = "Dep.Category temporary sist";
    LookupPageID = "Dep.Category temporary sist";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
                //EVALUATE(Order,Code);
                /*Dep.SETFILTER(Code,'%1',xRec.Code);
                Dep.SETFILTER("ORG Shema",'%1',"Org Shema");
                IF Dep.FINDSET THEN REPEAT
                  IF Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description")
                    THEN
                    Dep.RENAME(Rec.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description")
                      UNTIL Dep.NEXT=0;
                      *//*
                SectorCheckLength.RESET;
                IF SectorCheckLength.FINDSET THEN REPEAT
                IF STRLEN(Rec.Code)<STRLEN(SectorCheckLength.Code) THEN ERROR(Text002);
                UNTIL SectorCheckLength.NEXT=0;
                  OsPreparation.RESET;
                OsPreparation.SETFILTER(Status,'%1',2);
                IF OsPreparation.FINDLAST THEN BEGIN
                "Org Shema":=OsPreparation.Code;
                END
                ELSE BEGIN
                "Org Shema":='';
                END;
                "Department Type":=4;
                
                       IF Code<>'' THEN BEGIN
                       IF Description='' THEN BEGIN
                      DepartmentTemp.INIT;
                      DepartmentTemp.VALIDATE(Code,Code);
                      String:=Rec.Code;
                      IF String[STRLEN(Rec.Code)]='.' THEN
                      DepartmentTemp.Code:=Rec.Code;
                      DepartmentTemp."Department Category":=Rec.Code;
                      DepartmentTemp."Department Type":=4;
                      DepartmentTemp.INSERT;
                      END
                      ELSE BEGIN
                      DepartmentTemp.SETFILTER(Code,'%1',xRec.Code);
                      DepartmentTemp.SETFILTER(Description,'%1',Description);
                      DepartmentTemp.SETFILTER("Department Type",'%1',4);
                      IF DepartmentTemp.FINDFIRST THEN BEGIN
                      IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'','','',DepartmentTemp.Description) THEN BEGIN
                     // IF String[STRLEN(Rec.Code)]='.' THEN BEGIN
                      DepartmentTemp1.RENAME(Rec.Code,"Org Shema",Rec.Description,'','',Rec.Description);
                    { END
                      ELSE BEGIN
                      String:=FORMAT(Rec.Code);
                         LengthString:=STRLEN(String);
                         Brojac:=0;
                         FOR i:=1 TO LengthString DO BEGIN
                         IF String[i]='.'THEN BEGIN
                            Brojac:=Brojac+1;
                            IF Brojac=3 THEN
                            CodeDifferent:=i;
                               END;
                                END;}
                   //   DepartmentTemp1.RENAME(COPYSTR(Rec.Code,1,CodeDifferent),"Org Shema",Rec.Description,'','','Glavna filijala');
                             END;
                      SectorFind.RESET;
                       String:=FORMAT(Rec.Code);
                         LengthString:=STRLEN(String);
                         Brojac:=0;
                         FOR i:=1 TO LengthString DO BEGIN
                         IF String[i]='.'THEN BEGIN
                            Brojac:=Brojac+1;
                
                                                IF Brojac=2 THEN
                                                  SectorFind1:=i;
                
                                         END;
                                                     END;
                                                     SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorFind1));
                                                     IF SectorFind.FINDFIRST THEN BEGIN
                
                      DepartmentTemp1.Sector:=SectorFind.Code;
                      DepartmentTemp1."Sector  Description":=SectorFind.Description;
                      DepartmentTemp1."Sector Identity":=SectorFind.Identity;
                      "Identity Sector":=SectorFind.Identity;
                      DepartmentTemp1."Department Idenity":=Rec.Identity;
                      END;
                
                      DepartmentTemp1.MODIFY;
                      END;
                    END;
                {END;
                 END;}
                 END;*/

            end;
        }
        field(2; Day; Option)
        {
            Caption = 'Day';
            OptionCaption = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(3; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            NotBlank = true;
        }
        field(4; "Starting Time"; Time)
        {
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                /*IF ("Ending Time" = 0T) OR
                   ("Ending Time" < "Starting Time")
                THEN BEGIN
                  ShopCalendar.SETRANGE(Code,Code);
                  ShopCalendar.SETRANGE(Day,Day);
                  ShopCalendar.SETRANGE("Starting Time","Starting Time",235959T);
                  IF ShopCalendar.FINDFIRST THEN
                    "Ending Time" := ShopCalendar."Starting Time"
                  ELSE
                    "Ending Time" := 235959T;
                END;
                CheckRedundancy;
                */

            end;
        }
        field(5; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                /*IF ("Ending Time" < "Starting Time") AND
                   ("Ending Time" <> 000000T)
                THEN
                  ERROR(Text000,FIELDCAPTION("Ending Time"),FIELDCAPTION("Starting Time"));
                
                CheckRedundancy;
                */

            end;
        }
        field(12; n; Option)
        {
            OptionMembers = ,Percentage,First,Last,"First 1","First 2";
        }
        field(50000; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                /*Dep.SETFILTER(Code,'%1',Rec.Code);
                Dep.SETFILTER("ORG Shema",'%1',"Org Shema");
                
                IF Dep.FINDSET THEN REPEAT
                  IF Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description",xRec.Description)
                    THEN BEGIN
                    Dep.RENAME(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description",Rec.Description) ;
                     // Dep.Description:=Rec.Description;
                     // Dep.MODIFY;
                      END;
                      UNTIL Dep.NEXT=0;*/
                /* OsPreparation.RESET;
           OsPreparation.SETFILTER(Status,'%1',2);
           IF OsPreparation.FINDLAST THEN BEGIN
           "Org Shema":=OsPreparation.Code;
           END
           ELSE BEGIN
           "Org Shema":='';
           END;
           "Department Type":=4;
                  IF Rec.Description<>'' THEN BEGIN
                             IF Rec.Code<>'' THEN BEGIN
                 DepartmentTemp.SETFILTER("Department Category",'%1',Rec.Code);
                 DepartmentTemp.SETFILTER("Department Type",'%1',4);

                      IF DepartmentTemp.FIND('-') THEN BEGIN
                     { IF STRPOS(Description,'Glavna filijala')<>0 THEN BEGIN
                 NewDescription:='Glavna filijala';
                 END
                 ELSE BEGIN }
                 NewDescription:=Description;
                 //END;
                 String:=FORMAT(Rec.Code);
                    LengthString:=STRLEN(String);
                    Brojac:=0;
                 {TheLastCharacter:=STRLEN(Rec.Code);
                 CheckPoint:=Rec.Code;
              IF CheckPoint[TheLastCharacter]<>'.' THEN BEGIN }
              Brojac:=0;
                    FOR i:=1 TO STRLEN(Rec.Code) DO BEGIN
                    IF String[i]='.'THEN BEGIN
                       Brojac:=Brojac+1;
                                IF Brojac=2 THEN BEGIN
                                             SectorFind1:=i;
                                             END;
                                  END;
                                    END;


                 IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'',DepartmentTemp."Department Categ.  Description",'',DepartmentTemp.Description) THEN
                 DepartmentTemp1.RENAME(Rec.Code,"Org Shema",'',Description,'',NewDescription);
                { END
                 ELSE BEGIN
                 IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'',DepartmentTemp."Department Categ.  Description",'',DepartmentTemp.Description) THEN
                 DepartmentTemp1.RENAME(Code,"Org Shema",'',Description,'',NewDescription);}
                 END;
                SectorFind.RESET;
                  String:=FORMAT(Rec.Code);
                    LengthString:=STRLEN(String);
                    Brojac:=0;
                    FOR i:=1 TO LengthString DO BEGIN
                    IF String[i]='.'THEN BEGIN
                       Brojac:=Brojac+1;

                                           IF Brojac=2 THEN BEGIN
                                             SectorFind1:=i;
                                             END;
                                    END;
                                                END;
                                                SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorFind1));
                                                IF SectorFind.FINDFIRST THEN BEGIN

                 DepartmentTemp1.Sector:=SectorFind.Code;
                 DepartmentTemp1."Sector  Description":=SectorFind.Description;
                DepartmentTemp1."Sector Identity":=SectorFind.Identity;
                 END;
                DepartmentTemp1."Department Idenity":=Rec.Identity;
                  "Identity Sector":=SectorFind.Identity;
                 DepartmentTemp1.MODIFY;

                           END
                 ELSE BEGIN
                 DepartmentTemp1.INIT;
                 DepartmentTemp1.Description:=Rec.Description;
                  SectorFind.RESET;
                  String:=FORMAT(Rec.Code);
                    LengthString:=STRLEN(String);
                    Brojac:=0;
                    FOR i:=1 TO LengthString DO BEGIN
                    IF String[i]='.'THEN BEGIN
                       Brojac:=Brojac+1;

                                           IF Brojac=2 THEN BEGIN
                                             SectorFind1:=i;
                                             END;
                                    END;
                                                END;
                                                SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorFind1));
                                                IF SectorFind.FINDFIRST THEN BEGIN
                  DepartmentTemp1.Sector:=SectorFind.Code;
                 DepartmentTemp1."Sector  Description":=SectorFind.Description;
                 DepartmentTemp1."Sector Identity":=SectorFind.Identity;
                   "Identity Sector":=SectorFind.Identity;
                 DepartmentTemp1.INSERT;
                 END;
              END;
           END;*/
                //END;

            end;
        }
        field(50001; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50002; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50003; "Order"; Integer)
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
        field(50008; "Identity Sector"; Integer)
        {
        }
        field(50010; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension temporary"."Dimension Value Code" WHERE("Code" = FIELD("Code"),
                                                                                "Department Categ.  Description" = FIELD(Description),
                                                                                "Department Category" = FIELD("Code"));

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
        field(50011; "Dimension  Name"; Text[250])
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
            CalcFormula = Count("Dimension temporary" WHERE("Department Categ.  Description" = FIELD(Description),
                                                             "Department Type" = FIELD("Department Type"),
                                                             "ORG Shema" = FIELD("Org Shema")));
            Caption = 'Number of dimension value';

        }
        field(50014; "Number Of Group levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE("Department Category" = FIELD("Code"),
                                                              "Department Type" = FILTER("Group"),
                                                              "Department Categ.  Description" = FIELD(Description)));
            Caption = 'Number Of Group levels below';

        }
        field(50015; "Number Of Team  levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE("Department Category" = FIELD("Code"),
                                                              "Department Type" = FILTER(Team),
                                                              "Department Categ.  Description" = FIELD(Description)));
            Caption = 'Number Of Team  levels below';

        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                /*IF FORMAT(Rec."Residence/Network")<>'' THEN BEGIN
                  IF Code<>'' THEN BEGIN
                  IF Description<>'' THEN BEGIN
                    DepartmentTemp.RESET;
                    DepartmentTemp.SETFILTER("Department Category",'%1',Rec.Code);
                    DepartmentTemp.SETFILTER("Department Categ.  Description",'%1',Rec.Description);
                    DepartmentTemp.SETFILTER("Department Type",'%1',4);
                    IF DepartmentTemp.FINDFIRST THEN BEGIN
                      DepartmentTemp."Residence/Network":="Residence/Network";
                      DepartmentTemp.MODIFY;
                      END;
                
                END;
                    END;
                       END;*/

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
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translate of DepCat"; Text[250])
        {
            Caption = 'Official Translate of DepCat';
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

    trigger OnInsert()
    begin
        //CheckRedundancy;
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("B-1 (with regions) Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."B-1 (with regions) Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    trigger OnRename()
    begin
        //CheckRedundancy;
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        Text001: Label 'There is redundancy in the Shop Calendar. Actual work shift %1 from : %2 to %3. Conflicting work shift %4 from : %5 to %6.';
        ShopCalendar: Record "Department Category";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        DimensionNew: Record "Dimension temporary";
        OsPreparation: Record "ORG Shema";
        SectorFind: Record "Sector temporary";
        String: Text;
        Brojac: Integer;
        i: Integer;
        DepartmentTemp: Record "Department temporary";
        LengthString: Integer;
        SectorFind1: Integer;
        DepartmentTemp1: Record "Department temporary";
        NewDescription: Text;
        TheLastCharacter: Integer;
        TheSame: Integer;
        NewCode: Code[20];
        LastCharacter: Integer;
        CheckPoint: Code[20];
        CodeDifferent: Integer;
        SectorCheckLength: Record "Sector temporary";
        Text002: Label 'This code is wrong';

    local procedure CheckRedundancy()
    var
        ShopCalendar2: Record "Department Category";
        TempShopCalendar: Record "Department Category" temporary;
    begin
        /*ShopCalendar2.SETRANGE(Code,Code);
        ShopCalendar2.SETRANGE(Day,Day);
        IF ShopCalendar2.FIND('-') THEN
          REPEAT
            TempShopCalendar := ShopCalendar2;
            TempShopCalendar.INSERT;
          UNTIL ShopCalendar2.NEXT = 0;
        
        TempShopCalendar := xRec;
        IF TempShopCalendar.DELETE THEN ;
        
        TempShopCalendar.SETRANGE(Code,Code);
        TempShopCalendar.SETRANGE(Day,Day);
        TempShopCalendar.SETRANGE("Starting Time",0T,"Ending Time" - 1);
        TempShopCalendar.SETRANGE("Ending Time","Starting Time" + 1,235959T);
        
        IF TempShopCalendar.FINDFIRST THEN
          ERROR(
            Text001,
            "Work Shift Code",
            "Starting Time",
            "Ending Time",
            TempShopCalendar."Work Shift Code",
            TempShopCalendar."Starting Time",
            TempShopCalendar."Ending Time");
        */

    end;

    procedure SetParam("Code": Code[10]; Description: Text)
    begin
        Code := Rec.Code;
        Description := Rec.Description;
    end;
}

