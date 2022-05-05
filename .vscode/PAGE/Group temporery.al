table 50181 "Group temporary"
{
    Caption = 'Group';
    DrillDownPageID = "Group temporary sist";
    LookupPageID = "Group temporary sist";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
                /*Dep.SETFILTER(Code,'%1',xRec.Code);
                Dep.SETFILTER("ORG Shema",'%1',"Org Shema");
                IF Dep.FINDSET THEN REPEAT
                  IF Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description")
                    THEN
                    Dep.RENAME(Rec.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description")
                      UNTIL Dep.NEXT=0;*/
                /* OsPreparation.RESET;
            OsPreparation.SETFILTER(Status,'%1',2);
            IF OsPreparation.FINDLAST THEN BEGIN
            "Org Shema":=OsPreparation.Code;
            END
            ELSE BEGIN
            "Org Shema":='';
            END;
            "Department Type":=2;
            SectorCheckLength.RESET;
            IF SectorCheckLength.FINDSET THEN REPEAT
            IF STRLEN(Rec.Code)<STRLEN(SectorCheckLength.Code) THEN ERROR(Text002);
            UNTIL SectorCheckLength.NEXT=0;
                   IF Code<>'' THEN BEGIN
                   IF Description='' THEN BEGIN
                  DepartmentTemp.INIT;
                  DepartmentTemp.VALIDATE(Code,Code);
                  String:=Rec.Code;
                  //IF String[STRLEN(Rec.Code)]='.' THEN
                  DepartmentTemp.Code:=Rec.Code;
                  DepartmentTemp."Group Code":=Rec.Code;
                  DepartmentTemp."Department Type":=2;
                  DepartmentTemp.INSERT;
                  END
                  ELSE BEGIN
                  DepartmentTemp.SETFILTER("Group Code",'%1',xRec.Code);
                  DepartmentTemp.SETFILTER("Group Description",'%1',Description);
                  DepartmentTemp.SETFILTER("Department Type",'%1',2);
                  IF DepartmentTemp.FINDFIRST THEN BEGIN
                  IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",DepartmentTemp."Team Description",DepartmentTemp."Department Categ.  Description",DepartmentTemp."Group Description",DepartmentTemp.Description) THEN BEGIN
                 // IF String[STRLEN(Rec.Code)]='.' THEN BEGIN
                  DepartmentTemp1.RENAME(Rec.Code,"Org Shema",DepartmentTemp."Team Description",Rec."Belongs to Department Category",Rec.Description,Rec.Description);
                  END;
                 { ELSE BEGIN
                  String:=FORMAT(Rec.Code);
                     LengthString:=STRLEN(String);
                     Brojac:=0;
                     FOR I:=1 TO LengthString DO BEGIN
                     IF String[I]='.'THEN BEGIN
                        Brojac:=Brojac+1;
                        IF Brojac=3 THEN
                        CodeDifferent:=I;
                           END;
                            END;
                  DepartmentTemp1.RENAME(COPYSTR(Rec.Code,1,CodeDifferent),"Org Shema",DepartmentTemp."Team Description",Rec."Belongs to Department Category",Rec.Description,'Glavna filijala');
                         END;}
                  SectorFind.RESET;
                   String:=FORMAT(Rec.Code);
                     LengthString:=STRLEN(String);
                     Brojac:=0;
                     FOR I:=1 TO LengthString DO BEGIN
                     IF String[I]='.'THEN BEGIN
                        Brojac:=Brojac+1;

                                            IF Brojac=2 THEN
                                              SectorFind1:=I;

                                     END;
                                                 END;
                                                 SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorFind1));
                                                 IF SectorFind.FINDFIRST THEN BEGIN

                  DepartmentTemp1.Sector:=SectorFind.Code;
                  DepartmentTemp1."Sector  Description":=SectorFind.Description;
                  DepartmentTemp1."Sector Identity":=SectorFind.Identity;
                  DepartmentTemp1."Department Idenity":=Rec.Identity;
                  FindDep.RESET;
                  FindDep.SETFILTER(Description,'%1',Rec."Belongs to Department Category");
                  IF FindDep.FINDFIRST THEN BEGIN
                  DepartmentTemp1."Department Category":=FindDep.Code;
                  "Dep Cat Identity":=FindDep.Identity;
                  END;
                  END;

                  DepartmentTemp1.MODIFY;
                  END;
                END;
            END;
             //END;
             */

            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Starting Date-Time" := CREATEDATETIME(Date, "Starting Time");
                IF "Ending Date-Time" <> 0DT THEN
                    "Ending Date-Time" := CREATEDATETIME(Date, "Ending Time");
            end;
        }
        field(3; "Starting Time"; Time)
        {
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                IF ("Ending Time" = 0T) OR
                   ("Ending Time" < "Starting Time")
                THEN
                    "Ending Time" := "Starting Time";

                VALIDATE("Ending Time");
            end;
        }
        field(4; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                IF "Ending Time" < "Starting Time" THEN
                    ERROR(Text000, FIELDCAPTION("Ending Time"), FIELDCAPTION("Starting Time"));

                UpdateDatetime;
            end;
        }
        field(5; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';

            trigger OnValidate()
            begin
                "Starting Time" := DT2TIME("Starting Date-Time");
                Date := DT2DATE("Starting Date-Time");
                VALIDATE("Starting Time");
            end;
        }
        field(6; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';

            trigger OnValidate()
            begin
                /*"Ending Time" := DT2TIME("Ending Date-Time");
                Date := DT2DATE("Ending Date-Time");
                VALIDATE("Ending Time");
                */

            end;
        }
        field(10; Description; Text[250])
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
                      //Dep.Description:=Rec.Description;
                     // Dep.MODIFY;
                      END;
                      UNTIL Dep.NEXT=0;*/
                /*OsPreparation.RESET;
               OsPreparation.SETFILTER(Status,'%1',2);
               IF OsPreparation.FINDLAST THEN BEGIN
               "Org Shema":=OsPreparation.Code;
               END
               ELSE BEGIN
               "Org Shema":='';
               END;
               "Department Type":=2;
                      IF Rec.Description<>'' THEN BEGIN
                                 IF Rec.Code<>'' THEN BEGIN
                     DepartmentTemp.SETFILTER("Group Code",'%1',Rec.Code);
                     DepartmentTemp.SETFILTER("Department Type",'%1',2);


                          IF DepartmentTemp.FIND('-') THEN BEGIN
                          {IF STRPOS(Description,'Filijala')<>0 THEN BEGIN
                     NewDescription:='Filijala';
                     END
                     ELSE BEGIN }
                     NewDescription:=Description;
                    // END;
                     String:=FORMAT(Rec.Code);
                        LengthString:=STRLEN(String);
                        Brojac:=0;
                     TheLastCharacter:=STRLEN(Rec.Code);
                     CheckPoint:=Rec.Code;
                 // IF CheckPoint[TheLastCharacter]<>'.' THEN BEGIN
                  Brojac:=0;
                        FOR I:=1 TO STRLEN(Rec.Code) DO BEGIN
                        IF String[I]='.'THEN BEGIN
                           Brojac:=Brojac+1;
                                    IF Brojac=2 THEN BEGIN
                                                 SectorFind1:=I;
                                                 END;
                                      END;
                                        END;


                     IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'','',DepartmentTemp."Group Description",DepartmentTemp.Description) THEN
                     DepartmentTemp1.RENAME(Rec.Code,"Org Shema",'',Rec."Belongs to Department Category",Rec.Description,NewDescription);

                     {
                     ELSE BEGIN
                     IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'','',DepartmentTemp."Group Description",DepartmentTemp.Description) THEN
                     DepartmentTemp1.RENAME(Code,"Org Shema",'',Rec."Belongs to Department Category",Description,NewDescription);
                     END;}
                    SectorFind.RESET;
                      String:=FORMAT(Rec.Code);
                        LengthString:=STRLEN(String);
                        Brojac:=0;
                        FOR I:=1 TO LengthString DO BEGIN
                        IF String[I]='.'THEN BEGIN
                           Brojac:=Brojac+1;

                                               IF Brojac=2 THEN BEGIN
                                                 SectorFind1:=I;
                                                 END;
                                        END;
                                                    END;
                                                    SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorFind1));
                                                    IF SectorFind.FINDFIRST THEN BEGIN

                     DepartmentTemp1.Sector:=SectorFind.Code;
                     DepartmentTemp1."Sector  Description":=SectorFind.Description;
                     DepartmentTemp1."Sector Identity":=SectorFind.Identity;
                       "Dep Cat Identity":=FindDep.Identity;
                     FindDep.RESET;
                     FindDep.SETFILTER(Description,'%1',"Belongs to Department Category");
                     IF FindDep.FINDFIRST THEN BEGIN
                     DepartmentTemp1."Department Category":=FindDep.Code;
                     DepartmentTemp1."Department Idenity":=FindDep.Identity;
                       "Dep Cat Identity":=FindDep.Identity;
                     END;
                      END;

                     DepartmentTemp1.MODIFY;

                               END
                     ELSE BEGIN
                     DepartmentTemp1.INIT;
                     {IF STRPOS(Description,'Filijala')=0 THEN BEGIN
                     DepartmentTemp1.Description:='Filijala';
                     END
                     ELSE BEGIN
                     DepartmentTemp1.Description:=Description;
                     END;}
                      DepartmentTemp1.Description:=Rec.Description;
                      SectorFind.RESET;
                      String:=FORMAT(Rec.Code);
                        LengthString:=STRLEN(String);
                        Brojac:=0;
                        FOR I:=1 TO LengthString DO BEGIN
                        IF String[I]='.'THEN BEGIN
                           Brojac:=Brojac+1;

                                               IF Brojac=2 THEN BEGIN
                                                 SectorFind1:=I;
                                                 END;
                                        END;
                                                    END;
                                                    SectorFind.SETFILTER(Code,'%1',COPYSTR(Rec.Code,1,SectorFind1));
                                                    IF SectorFind.FINDFIRST THEN BEGIN
                    DepartmentTemp1.Sector:=SectorFind.Code;
                     DepartmentTemp1."Sector  Description":=SectorFind.Description;
                     DepartmentTemp1."Sector Identity":=SectorFind.Identity;
                     FindDep.RESET;
                     FindDep.SETFILTER(Description,'%1',"Belongs to Department Category");
                     IF FindDep.FINDFIRST THEN BEGIN
                     DepartmentTemp1."Department Category":=FindDep.Code;
                     DepartmentTemp1."Department Idenity":=FindDep.Identity;
                       "Dep Cat Identity":=FindDep.Identity;
                     END;
                      END;
                     DepartmentTemp1.INSERT;
                     END;
                  END;
               END;
                */

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
        field(50002; "Changing Department"; Boolean)
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
        field(50003; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50004; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50006; Identity; Integer)
        {
            AutoIncrement = true;
            Caption = 'Identity';
        }
        field(50010; "Dimension Value Code"; Code[20])
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
        field(50012; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temporary" WHERE("Group Description" = FIELD(Description),
                                                             "Department Type" = FIELD("Department Type"),
                                                            "ORG Shema" = FIELD("Org Shema")));
            Caption = 'Number of dimension value';


        }
        field(50013; "Number Of Team  levels below"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE("Group Code" = FIELD("Code"),
                                                              "Department Type" = FILTER("Team"),
                                                              "Group Description" = FIELD(Description)));
            Caption = 'Number Of Team  levels below';

        }
        field(50015; "Dep Cat Identity"; Integer)
        {
        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                /*IF FORMAT(Rec."Residence/Network")<>'' THEN BEGIN
                  IF Rec.Code<>'' THEN BEGIN
                  IF Rec.Description<>'' THEN BEGIN
                    DepartmentTemp.RESET;
                    DepartmentTemp.SETFILTER("Group Code",'%1',Rec.Code);
                    DepartmentTemp.SETFILTER("Group Description",'%1',Rec.Description);
                    DepartmentTemp.SETFILTER("Department Type",'%1',2);
                    IF DepartmentTemp.FINDFIRST THEN BEGIN
                      DepartmentTemp."Residence/Network":="Residence/Network";
                      DepartmentTemp.MODIFY;
                      END;
                
                END;
                    END;
                       END;
                       */

            end;
        }
        field(50017; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;
        }
        field(50018; "Belongs to Department Category"; Text[250])
        {
            Caption = 'Belongs to Department Category';
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("Org Shema"));

            trigger OnValidate()
            begin
                /*IF "Belongs to Department Category"<>'' THEN BEGIN
                  DepartmentRename.RESET;
                  DepartmentRename.SETFILTER("Department Type",'%1',2);
                  DepartmentRename.SETFILTER("Group Code",'%1',Rec.Code);
                  DepartmentRename.SETFILTER("Group Description",'%1',Rec.Description);
                  IF DepartmentRename.FINDFIRST THEN BEGIN
                
                  IF DepartmentRename1.GET(DepartmentRename.Code,DepartmentRename."ORG Shema",'','',DepartmentRename."Group Description",DepartmentRename.Description)
                    THEN
                    DepartmentRename1.RENAME(DepartmentRename.Code,DepartmentRename."ORG Shema",'',"Belongs to Department Category",DepartmentRename."Group Description",DepartmentRename.Description) ;
                  FindCodeForDep.RESET;
                  FindCodeForDep.SETFILTER(Description,'%1',"Belongs to Department Category");
                  IF FindCodeForDep.FINDFIRST THEN BEGIN
                  DepartmentRename1."Department Category":=FindCodeForDep.Code;
                    DepartmentRename1."Department Idenity":=FindCodeForDep.Identity;
                    Rec."Dep Cat Identity":=FindCodeForDep.Identity;
                  END
                  ELSE BEGIN
                  DepartmentRename1."Department Category":='';
                  END;
                    DepartmentRename1.MODIFY;
                    END;
                      END;*/

            end;
        }
        field(50019; LastModified; Text[250])
        {
            Caption = 'Last modified code';
        }
        field(50020; "Identity Sector"; Integer)
        {
        }
        field(50021; "Name of TC"; Text[250])
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
        field(500402; "Official Translate of Group"; Text[250])
        {
            Caption = 'Official Translate of group';
        }
        field(500403; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
        }
        field(500404; Ispis; Boolean)
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
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Stream Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Stream Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        DimensionNew: Record "Dimension temporary";
        DepartmentTemp: Record "Department temporary";
        OsPreparation: Record "ORG Shema";
        SectorFind: Record "Sector temporary";
        DepartmentTemp1: Record "Department temporary";
        String: Text;
        LengthString: Integer;
        Brojac: Integer;
        I: Integer;
        SectorFind1: Integer;
        NewDescription: Text;
        TheLastCharacter: Integer;
        CheckPoint: Code[20];
        TheSame: Integer;
        NewCode: Code[20];
        DepartmentRename: Record "Department temporary";
        FindCodeForDep: Record "Department Category temporary";
        CodeDifferent: Integer;
        FindDep: Record "Department Category temporary";
        DepartmentRename1: Record "Department temporary";
        SectorCheckLength: Record "Department Category temporary";
        Text002: Label 'This code is wrong';

    local procedure UpdateDatetime()
    begin
        /*"Starting Date-Time" := CREATEDATETIME(Date,"Starting Time");
        "Ending Date-Time" := CREATEDATETIME(Date,"Ending Time");
        */

    end;
}

