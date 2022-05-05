table 50043 Department
{
    // //

    Caption = 'Department';
    DrillDownPageID = "Department";
    LookupPageID = "Department";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                //Sektor
                SectorT.RESET;
                SectorT.SETFILTER(Code, '%1', Rec.Code);
                SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
                IF SectorT.FINDFIRST THEN BEGIN
                    Zapis := SectorT.COUNT;
                    "Department Type" := 8;
                    IF Zapis = 1 THEN BEGIN
                        VALIDATE("Sector  Description", SectorT.Description);
                        Description := SectorT.Description;
                        SectorT.RESET;
                        SectorT.SETFILTER(Description, '%1', SectorT.Description);
                        IF SectorT.FINDFIRST THEN
                            Sector := SectorT.Code;
                        IF STRLEN(Sector) = 2 THEN BEGIN
                            "Managing Org 1" := SectorT.Code;
                        END
                        ELSE BEGIN
                            "Managing Org 2" := SectorT.Code;
                            "Managing Org 1" := COPYSTR(SectorT.Code, 1, 2);
                        END;
                    END;
                END;

                //odjel
                DepartmentCategoryT.RESET;
                DepartmentCategoryT.SETFILTER("Org Shema", '%1', "ORG Shema");
                DepartmentCategoryT.SETFILTER(Code, '%1', Rec.Code);
                IF DepartmentCategoryT.FINDFIRST THEN BEGIN
                    Zapis := DepartmentCategoryT.COUNT;
                    "Department Type" := 4;
                    IF Zapis = 1 THEN BEGIN
                        Description := DepartmentCategoryT.Description;
                        VALIDATE("Department Categ.  Description", DepartmentCategoryT.Description);
                        Dep.RESET;
                        Dep.SETFILTER(Description, '%1', DepartmentCategoryT.Description);
                        Dep.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF Dep.FINDFIRST THEN BEGIN
                            "Managing Org 1" := Dep."Department Category";
                            "Managing Org 2" := Dep.Sector;
                            "Managing Org 3" := COPYSTR(Dep.Sector, 1, 2);

                        END
                        ELSE BEGIN
                            "Managing Org 1" := '';
                            "Managing Org 2" := '';
                            "Managing Org 3" := '';
                        END;

                        String := FORMAT(Rec.Code);
                        Brojac := 0;
                        FOR i := 1 TO STRLEN(Rec.Code) DO BEGIN
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 2 THEN
                                    j := i;
                            END;
                        END;
                        IF j <> 0 THEN BEGIN
                            SectorT.RESET;
                            SectorT.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, j));
                            SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
                            IF SectorT.FINDFIRST THEN BEGIN
                                VALIDATE("Sector  Description", SectorT.Description);
                                SectorT.RESET;
                                SectorT.SETFILTER(Description, '%1', SectorT.Description);
                                IF SectorT.FINDFIRST THEN
                                    Sector := SectorT.Code;
                            END;
                        END;
                    END;
                END;

                GroupT.RESET;
                GroupT.SETFILTER("Org Shema", '%1', "ORG Shema");
                GroupT.SETFILTER(Code, '%1', Rec.Code);
                IF GroupT.FINDFIRST THEN BEGIN
                    Zapis := GroupT.COUNT;
                    "Department Type" := 2;
                    IF Zapis = 1 THEN BEGIN
                        Description := GroupT.Description;
                        VALIDATE("Group Description", GroupT.Description);
                        Dep.RESET;
                        Dep.SETFILTER(Description, '%1', GroupT.Description);
                        Dep.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF Dep.FINDFIRST THEN BEGIN
                            "Managing Org 1" := Dep."Group Code";
                            "Managing Org 2" := Dep."Department Category";
                            "Managing Org 3" := Dep.Sector;
                            "Managing Org 4" := COPYSTR(Dep.Sector, 1, 2);

                        END
                        ELSE BEGIN
                            "Managing Org 1" := '';
                            "Managing Org 2" := '';
                            "Managing Org 3" := '';
                            "Managing Org 4" := '';
                        END;

                        "Group Code" := Rec.Code;
                        String := FORMAT(Rec.Code);
                        Brojac := 0;
                        FOR i := 1 TO STRLEN(Rec.Code) DO BEGIN
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 2 THEN
                                    j := i;
                                IF Brojac = 3 THEN
                                    K := i;
                            END;
                        END;
                        IF j <> 0 THEN BEGIN
                            SectorT.RESET;
                            SectorT.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, j));
                            SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
                            IF SectorT.FINDFIRST THEN BEGIN
                                VALIDATE("Sector  Description", SectorT.Description);
                                SectorT.RESET;
                                SectorT.SETFILTER(Description, '%1', SectorT.Description);
                                IF SectorT.FINDFIRST THEN
                                    Sector := SectorT.Code;
                            END;
                        END;
                        IF K <> 0 THEN BEGIN
                            DepartmentCategoryT.RESET;
                            DepartmentCategoryT.SETFILTER("Org Shema", '%1', "ORG Shema");
                            DepartmentCategoryT.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, K));
                            IF DepartmentCategoryT.FINDFIRST THEN BEGIN
                                IF DepartmentCategoryT.COUNT = 1 THEN BEGIN
                                    VALIDATE("Department Categ.  Description", DepartmentCategoryT.Description);
                                END;
                            END;
                        END;


                    END;
                END;

                TeamT.RESET;
                TeamT.SETFILTER("Org Shema", '%1', "ORG Shema");
                TeamT.SETFILTER(Code, '%1', Rec.Code);
                IF TeamT.FINDFIRST THEN BEGIN
                    Zapis := TeamT.COUNT;
                    "Team Code" := Rec.Code;
                    "Department Type" := 9;
                    IF Zapis = 1 THEN BEGIN
                        Description := TeamT.Name;
                        VALIDATE("Team Description", TeamT.Name);
                        Dep.RESET;
                        Dep.SETFILTER(Description, '%1', TeamT.Name);
                        Dep.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF Dep.FINDFIRST THEN BEGIN
                            "Managing Org 1" := Dep."Team Code";
                            "Managing Org 2" := Dep."Group Code";
                            "Managing Org 3" := Dep."Department Category";
                            "Managing Org 4" := Dep.Sector;
                            "Managing Org 5" := COPYSTR(Dep.Sector, 1, 2);

                        END
                        ELSE BEGIN
                            "Managing Org 1" := '';
                            "Managing Org 2" := '';
                            "Managing Org 3" := '';
                            "Managing Org 4" := '';
                            "Managing Org 5" := '';
                        END;
                    END;
                    String := FORMAT(Rec.Code);
                    Brojac := 0;
                    FOR i := 1 TO STRLEN(Rec.Code) DO BEGIN
                        IF String[i] = '.' THEN BEGIN
                            Brojac := Brojac + 1;
                            IF Brojac = 2 THEN
                                j := i;
                            IF Brojac = 3 THEN
                                K := i;
                            IF Brojac = 4 THEN
                                z := i;
                        END;
                    END;
                    IF j <> 0 THEN BEGIN
                        SectorT.RESET;
                        SectorT.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, j));
                        SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
                        IF SectorT.FINDFIRST THEN BEGIN
                            VALIDATE("Sector  Description", SectorT.Description);
                            SectorT.RESET;
                            SectorT.SETFILTER(Description, '%1', SectorT.Description);
                            IF SectorT.FINDFIRST THEN
                                Sector := SectorT.Code;
                        END;
                    END;
                    IF K <> 0 THEN BEGIN
                        DepartmentCategoryT.RESET;
                        DepartmentCategoryT.SETFILTER("Org Shema", '%1', "ORG Shema");
                        DepartmentCategoryT.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, K));
                        IF DepartmentCategoryT.FINDFIRST THEN BEGIN
                            IF DepartmentCategoryT.COUNT = 1 THEN BEGIN
                                VALIDATE("Department Categ.  Description", DepartmentCategoryT.Description);
                            END;
                        END;
                    END;
                    IF z <> 0 THEN BEGIN
                        GroupT.RESET;
                        GroupT.SETFILTER("Org Shema", '%1', "ORG Shema");
                        GroupT.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, z));
                        IF GroupT.FINDFIRST THEN BEGIN
                            IF GroupT.COUNT = 1 THEN BEGIN
                                VALIDATE("Group Description", GroupT.Description);
                            END;
                        END;
                        "Team Code" := Rec.Code;
                    END;


                END;
            end;
        }
        field(2; Description; Text[130])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK   WPConnSetup.FINDFIRST();

                        /*
                        đk                        CREATE(conn, TRUE, TRUE);

                                                conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                                          + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                                                CREATE(comm, TRUE, TRUE);

                                                lvarActiveConnection := conn;
                                                comm.ActiveConnection := lvarActiveConnection;

                                                comm.CommandText := 'dbo.Department_Update';
                                                comm.CommandType := 4;
                                                comm.CommandTimeout := 0;

                                                param := comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@Code', 200, 1, 30, Code);
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@Description', 200, 1, 100, Description);
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@Type', 200, 1, 30, Type);
                                                comm.Parameters.Append(param);

                                                param := comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
                                                comm.Parameters.Append(param);
                                                param := comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                                                comm.Parameters.Append(param);
                                                comm.Execute;
                                                conn.Close;
                                                CLEAR(conn);
                                                CLEAR(comm);
                                                  đk */
                    END;
                END;


                /*NewDepartment.SETFILTER(Code,'%1',Rec.Code);
                NewDepartment.SETFILTER(Description,'%1',Rec.Description);
                NewDepartment.SETFILTER("ORG Shema",'%1',"ORG Shema");
                IF NewDepartment.FINDFIRST THEN BEGIN */
                /*IF "Department Type"=4 THEN BEGIN
                  DepartmentCategory.SETFILTER("Org Shema",'%1',"ORG Shema");
                  IF DepartmentCategory.FIND('-') THEN BEGIN
                  DepartmentCategory.INIT;
                  DepartmentCategory.Code:=Rec.Code;
                  DepartmentCategory.Description:=Rec.Description;
                  DepartmentCategory."Org Shema":="ORG Shema";
                  DepartmentCategory.INSERT;
                  END;
                  NewDepartment.SETFILTER(Code,'%1',Rec.Code);
                  NewDepartment.SETFILTER(Description,'%1',Rec.Description);
                  NewDepartment.SETFILTER("ORG Shema",'%1',"ORG Shema");
                  IF NewDepartment.FIND('-') THEN BEGIN
                  "Department Category":=Rec.Code;
                  "Department Categ.  Description":=Rec.Description;
                  END;
                  END;
                  IF "Department Type"=8 THEN BEGIN
                    SectorNew.SETFILTER("Org Shema",'%1',"ORG Shema");
                    IF SectorNew.FIND('-') THEN BEGIN
                      SectorNew.INIT;
                      SectorNew.Code:=Rec.Code;
                      SectorNew.Description:=Rec.Description;
                      SectorNew."Org Shema":="ORG Shema";
                      SectorNew.INSERT;
                      Sector:=Rec.Code;
                     "Sector  Description":=Rec.Description;
                      END;
                      END;
                        IF "Department Type"=2 THEN BEGIN
                        GroupNew.SETFILTER("Org Shema",'%1',"ORG Shema");
                        IF GroupNew.FIND('-') THEN BEGIN
                          GroupNew.INIT;
                          GroupNew.Code:=Rec.Code;
                          GroupNew.Description:=Rec.Description;
                          GroupNew."Org Shema":=Rec."ORG Shema";
                          GroupNew.INSERT;
                          "Group Code":=Rec.Code;
                          "Group Description":=Rec.Description;
                  END;
                  END;
                          IF "Department Type"=9 THEN BEGIN
                            Team1.SETFILTER("Org Shema",'%1',"ORG Shema");
                            IF Team1.FIND('-') THEN BEGIN
                              Team1.INIT;
                              Team1.Code:=Rec.Code;
                              Team1.Description:=Rec.Description;
                              Team1."Org Shema":=Rec."ORG Shema";
                              Team1.INSERT;
                              "Team Code":=Rec.Code;
                              "Team Description":=Rec.Description;
                              END;
                              END;
                               //  END;*/

            end;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Direction,Sector,Department';
            OptionMembers = " ",Direction,Sector,Department;
        }
        field(4; "Sector Code"; Code[30])
        {
            Caption = 'Sector code';
            TableRelation = IF (Type = CONST(Department)) Department.Code WHERE(Type = CONST(Sector));
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            FieldClass = Normal;
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
            TableRelation = "Post Code".City;
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(8; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = Sector.Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF Sector <> '' THEN BEGIN
                    "B-1Rec".RESET;
                    "B-1Rec".SETFILTER(Code, Sector);
                    "B-1Rec".SETFILTER("Org Shema", "ORG Shema");
                    IF "B-1Rec".FINDFIRST THEN
                        "Sector  Description" := "B-1Rec".Description;
                    "Sector Identity" := "B-1Rec".Identity;
                END
                ELSE
                    "Sector  Description" := '';

                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK WPConnSetup.FINDFIRST();


                        /* đk   CREATE(conn, TRUE, TRUE);

                           conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                     + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                           CREATE(comm, TRUE, TRUE);

                           lvarActiveConnection := conn;
                           comm.ActiveConnection := lvarActiveConnection;

                           comm.CommandText := 'dbo.Department_Update';
                           comm.CommandType := 4;
                           comm.CommandTimeout := 0;

                           param := comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Code', 200, 1, 30, Code);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Description', 200, 1, 100, Description);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Type', 200, 1, 30, Type);
                           comm.Parameters.Append(param);

                           param := comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                           comm.Parameters.Append(param);
                           comm.Execute;
                           conn.Close;
                           CLEAR(conn);
                           CLEAR(comm) đk */
                    END;
                END;
            end;
        }
        field(9; "Department Category"; Code[20])
        {
            Caption = 'Department';
            Editable = true;
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Department Category" <> '' THEN BEGIN
                    "B-1WithRegions".RESET;
                    "B-1WithRegions".SETFILTER(Code, "Department Category");
                    "B-1WithRegions".SETFILTER("Org Shema", "ORG Shema");
                    IF "B-1WithRegions".FINDFIRST THEN
                        "Department Categ.  Description" := "B-1WithRegions".Description;


                END
                ELSE
                    "Department Categ.  Description" := '';
                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK  WPConnSetup.FINDFIRST();


                        /*đk   CREATE(conn, TRUE, TRUE);

                           conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                     + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                           CREATE(comm, TRUE, TRUE);

                           lvarActiveConnection := conn;
                           comm.ActiveConnection := lvarActiveConnection;

                           comm.CommandText := 'dbo.Department_Update';
                           comm.CommandType := 4;
                           comm.CommandTimeout := 0;

                           param := comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Code', 200, 1, 30, Code);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Description', 200, 1, 100, Description);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Type', 200, 1, 30, Type);
                           comm.Parameters.Append(param);

                           param := comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                           comm.Parameters.Append(param);
                           comm.Execute;
                           conn.Close;
                           CLEAR(conn);
                           CLEAR(comm);*/
                    END;
                END;
            end;
        }
        field(10; "Group Code"; Code[30])
        {
            Caption = 'Group';
            Editable = true;
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK WPConnSetup.FINDFIRST();


                        /*   CREATE(conn, TRUE, TRUE);

                           conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                     + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));

                           CREATE(comm, TRUE, TRUE);

                           lvarActiveConnection := conn;
                           comm.ActiveConnection := lvarActiveConnection;

                           comm.CommandText := 'dbo.Department_Update';
                           comm.CommandType := 4;
                           comm.CommandTimeout := 0;

                           param := comm.CreateParameter('@OldCode', 200, 1, 30, xRec.Code);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Code', 200, 1, 30, Code);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Description', 200, 1, 100, Description);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@Type', 200, 1, 30, Type);
                           comm.Parameters.Append(param);

                           param := comm.CreateParameter('@B_1', 200, 1, 30, Sector);
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
                           comm.Parameters.Append(param);
                           param := comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
                           comm.Parameters.Append(param);
                           comm.Execute;
                           conn.Close;
                           CLEAR(conn);
                           CLEAR(comm);*/
                    END;
                END;
            end;
        }
        field(11; "Sector  Description"; Text[130])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Sector  Description" <> '' THEN BEGIN
                    SectorR.RESET;
                    SectorR.SETFILTER(Description, '%1', "Sector  Description");
                    SectorR.SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF SectorR.FINDFIRST THEN BEGIN
                        Sector := SectorR.Code;
                        "Sector Identity" := SectorR.Identity;
                    END
                    ELSE BEGIN
                        Sector := '';
                        "Sector Identity" := 0;
                    END;
                END
                ELSE BEGIN
                    "Sector  Description" := '';
                    Sector := '';
                    "Sector Identity" := 0;
                END;
            end;
        }
        field(12; "Department Categ.  Description"; Text[85])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF "Department Categ.  Description" <> '' THEN BEGIN
                    "B-1WithRegions".RESET;
                    "B-1WithRegions".SETFILTER(Description, '%1', "Department Categ.  Description");
                    "B-1WithRegions".SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF "B-1WithRegions".FINDFIRST THEN BEGIN
                        "Department Category" := "B-1WithRegions".Code;
                        "Department Idenity" := "B-1WithRegions".Identity;
                    END;
                END;
                IF "Department Categ.  Description" = '' THEN BEGIN
                    "Department Category" := '';
                    "Department Idenity" := 0;
                END;
            end;
        }
        field(13; "Group Description"; Text[85])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = Group.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF "Group Description" <> '' THEN BEGIN
                    StreamRec.RESET;
                    StreamRec.SETFILTER(Description, '%1', "Group Description");
                    StreamRec.SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF StreamRec.FINDFIRST THEN BEGIN
                        "Group Code" := StreamRec.Code;
                        "Department Group identity" := StreamRec.Identity;
                    END;
                END
                ELSE BEGIN
                    "Group Code" := '';
                    "Department Group identity" := 0;
                    "Group Description" := '';
                END;
            end;
        }
        field(14; Municipality; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code" WHERE("Code" = FIELD("ORG Dio")));
            Caption = 'Municipality';



            trigger OnValidate()
            begin
                /*ECL.SETFILTER( ECL."Employee No.","Employee No.");
                      IF ECL.FINDLAST THEN BEGIN
                      Emp.RESET;
                      Emp.SETFILTER("No.","Employee No.");
                      IF Emp.FINDFIRST() THEN
                       BEGIN
                        Emp."Inactive Date":=ECL."Ending Date";
                        Emp."Probation Period End":=ECL."Ending Date";
                        Emp.MODIFY;
                       END;
                      END;*/

                /*ECL.SETFILTER("Employee No.",Emp."No.");
                IF ECL.FINDFIRST THEN BEGIN
                 Department.SETFILTER(Code,ECL."Department Code");
                 IF Department.FINDFIRST THEN BEGIN
                 WC.SETFILTER("Employee No.",ECL."Employee No.");
                  WC."Department Municipality":=Department.Municipality;
                  END;
                  END;*/

            end;
        }
        field(15; "Department ID"; Text[50])
        {
            Caption = 'Department ID';
        }
        field(16; "Department IC"; Text[30])
        {
            Caption = 'IC';
        }
        field(18; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(19; "Timesheets administrator"; Code[10])
        {
            Caption = 'Timesheets administrator';
            TableRelation = Employee WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK    WPConnSetup.FINDFIRST();

                        /* CREATE(conn, TRUE, TRUE);

                         conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                    + ';PWD=' + WPConnSetup.Password);

                         CREATE(comm, TRUE, TRUE);

                         lvarActiveConnection := conn;
                         comm.ActiveConnection := lvarActiveConnection;

                         comm.CommandText := 'dbo.DepartmentUser_Update';
                         comm.CommandType := 4;
                         comm.CommandTimeout := 0;
                         param := comm.CreateParameter('@DepartmentCode', 200, 1, 30, Code);
                         comm.Parameters.Append(param);
                         param := comm.CreateParameter('@Timesheets_admin', 200, 1, 30, "Timesheets administrator");
                         comm.Parameters.Append(param);
                         param := comm.CreateParameter('@AdminOld', 200, 1, 30, xRec."Timesheets administrator");
                         comm.Parameters.Append(param);


                         comm.Execute;
                         conn.Close;
                         CLEAR(conn);
                         CLEAR(comm);*/
                    END;
                END;
            end;
        }
        field(20; "ORG Dio"; Code[10])
        {
            Caption = 'ORG Part';
            TableRelation = "ORG Dijelovi";
        }
        field(21; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;
        }
        field(22; Amount; Decimal)
        {
        }
        field(23; "Timesheets administrator 2"; Code[10])
        {
            Caption = 'Timesheets administrator 2';
            TableRelation = Employee WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK    WPConnSetup.FINDFIRST();

                        /*  CREATE(connAdm2, TRUE, TRUE);

                          connAdm2.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                     + ';PWD=' + WPConnSetup.Password);

                          CREATE(commAdm2, TRUE, TRUE);

                          lvarActiveConnectionAdm2 := connAdm2;
                          commAdm2.ActiveConnection := lvarActiveConnectionAdm2;

                          commAdm2.CommandText := 'dbo.DepartmentUser_Update_Admin2';
                          commAdm2.CommandType := 4;
                          commAdm2.CommandTimeout := 0;
                          paramAdm2 := commAdm2.CreateParameter('@DepartmentCode', 200, 1, 30, Code);
                          commAdm2.Parameters.Append(paramAdm2);
                          paramAdm2 := commAdm2.CreateParameter('@Timesheets_admin', 200, 1, 30, "Timesheets administrator 2");
                          commAdm2.Parameters.Append(paramAdm2);
                          paramAdm2 := commAdm2.CreateParameter('@AdminOld', 200, 1, 30, xRec."Timesheets administrator 2");
                          commAdm2.Parameters.Append(paramAdm2);


                          commAdm2.Execute;
                          connAdm2.Close;
                          CLEAR(connAdm2);
                          CLEAR(commAdm2);*/
                    END;
                END;
            end;
        }
        field(24; "Timesheets Manager"; Code[10])
        {
            Caption = 'Timesheets Manager';
            TableRelation = Employee WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin
                IF COMPANYNAME = 'SB' THEN BEGIN
                    OS.SETFILTER(Code, '%1', "ORG Shema");
                    OS.SETFILTER(Status, '%1', OS.Status::Active);
                    IF OS.FINDFIRST THEN BEGIN
                        //ĐK     WPConnSetup.FINDFIRST();

                        /*  CREATE(conn, TRUE, TRUE);

                          conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                                     + ';PWD=' + WPConnSetup.Password);

                          CREATE(comm, TRUE, TRUE);

                          lvarActiveConnection := conn;
                          comm.ActiveConnection := lvarActiveConnection;

                          comm.CommandText := 'dbo.DepartmentUser_Update_AdminManager';
                          comm.CommandType := 4;
                          comm.CommandTimeout := 0;
                          param := comm.CreateParameter('@DepartmentCode', 200, 1, 30, Code);
                          comm.Parameters.Append(param);
                          param := comm.CreateParameter('@Timesheets_admin', 200, 1, 30, "Timesheets Manager");
                          comm.Parameters.Append(param);
                          param := comm.CreateParameter('@AdminOld', 200, 1, 30, xRec."Timesheets Manager");
                          comm.Parameters.Append(param);


                          comm.Execute;
                          conn.Close;
                          CLEAR(conn);
                          CLEAR(comm);*/
                    END;
                END;
            end;
        }
        field(25; AmountHealth; Decimal)
        {
        }
        field(26; AmountTax; Decimal)
        {
        }
        field(27; "Cnfidential Clerk 1"; Code[10])
        {
            Caption = 'Cnfidential Clerk 1';
            //ĐK   TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin
                /*  Position.SETFILTER("Employee No.", '%1', "Cnfidential Clerk 1");
                  IF Position.FIND('-') THEN BEGIN
                      "Confidential Clerk 1 Position" := Position.Position;
                      "Confidential Clerk 1 Full Name" := Position."Employee Full Name";
                      MODIFY;
                  END
                  ELSE BEGIN
                      "Confidential Clerk 1 Position" := '';
                      "Confidential Clerk 1 Full Name" := '';
                      MODIFY;
                  END;*/
            end;
        }
        field(28; "Confidential Clerk 1 Position"; Text[250])
        {
            Caption = 'Confidential Clerk 1 Position';
        }
        field(29; "Cnfidential Clerk 2"; Code[10])
        {
            Caption = 'Cnfidential Clerk 2';
            //  TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin
                /*    Position2.SETFILTER("Employee No.", '%1', "Cnfidential Clerk 2");
                    IF Position2.FIND('-') THEN BEGIN
                        "Confidential Clerk 2 Position" := Position2.Position;
                        "Confidential Clerk 2 Full Name" := Position2."Employee Full Name";
                        MODIFY;
                    END
                    ELSE BEGIN
                        "Confidential Clerk 2 Position" := '';
                        "Confidential Clerk 2 Full Name" := '';
                        MODIFY;
                    END;*/
            end;
        }
        field(30; "Confidential Clerk 2 Position"; Text[250])
        {
            Caption = 'Confidential Clerk 2 Position';
        }
        field(31; "Confidential Clerk 1 Full Name"; Text[150])
        {
            Caption = 'Confidential Clerk 1 Full Name';
        }
        field(32; "Confidential Clerk 2 Full Name"; Text[150])
        {
            Caption = 'Confidential Clerk 1 Full Name';
        }
        field(33; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(34; "Managing Org 1"; Code[30])
        {
            Caption = 'Managing Org 1';
            TableRelation = Department;
        }
        field(35; "Managing Org 2"; Code[30])
        {
            Caption = 'Managing Org 2';
            TableRelation = Department;
        }
        field(36; "Managing Org 3"; Code[30])
        {
            Caption = 'Managing Org 3';
            TableRelation = Department;
        }
        field(37; "Managing Org 4"; Code[30])
        {
            Caption = 'Managing Org 4';
            TableRelation = Department;
        }
        field(38; "Managing Org 5"; Code[30])
        {
            Caption = 'Managing Org 5';
            TableRelation = Department;
        }
        field(39; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(40; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                          "Dimension Value Type" = FILTER("Standard"));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(41; "Dimension  Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                               "Code" = FIELD("Dimension Value Code")));
            Caption = 'Dimension Code';
            Editable = false;


            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(42; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = TeamT."Code" WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(43; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = TeamT."Name" WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Team Description" <> '' THEN BEGIN
                    TeamRec.RESET;
                    TeamRec.SETFILTER(Name, "Team Description");
                    TeamRec.SETFILTER("Org Shema", "ORG Shema");
                    IF TeamRec.FINDFIRST THEN
                        "Team Code" := TeamRec.Code;
                    // "Team Description":= LOWERCASE(TeamRec.Name);
                END
                ELSE
                    "Team Code" := '';



                //

                IF "Team Description" <> '' THEN BEGIN
                    TeamRec.RESET;
                    TeamRec.SETFILTER(Description, '%1', "Team Description");
                    TeamRec.SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF TeamRec.FINDFIRST THEN BEGIN
                        "Team Code" := TeamRec.Code;
                        "Department Team identity" := "B-1WithRegions".Identity;
                    END
                    ELSE BEGIN
                        "Team Code" := '';
                        "Department Team identity" := 0;
                    END;
                END
                ELSE BEGIN
                    "Team Code" := '';
                    "Department Team identity" := 0;
                    "Team Description" := '';
                END;
            end;
        }
        field(45; "Signatory 1"; Code[10])
        {
            Caption = 'Signatory person 1 ';
            // TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin
                /*  Position.SETFILTER("Employee No.", '%1', "Signatory 1");
                  IF Position.FIND('-') THEN BEGIN
                      "Signatory 1 Position" := Position.Position; //Pozicija potpisnika = Confidential Clerk.position
                      "Signatory 1 Full Name" := Position."Employee Full Name"; //Ime i prezime potpisnika:=Confidential Clerk. Employee Full Name
                      MODIFY;
                  END
                  ELSE BEGIN
                      "Signatory 1 Position" := '';
                      "Signatory 1 Full Name" := '';
                      MODIFY;
                  END;*/
            end;
        }
        field(46; "Signatory 2"; Code[10])
        {
            Caption = 'Signatory person 2';
            // TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin
                /*   Position.SETFILTER("Employee No.", '%1', "Signatory 2");
                   IF Position.FIND('-') THEN BEGIN
                       "Signatory 2 Position" := Position.Position;
                       "Signatory 2 Full Name" := Position."Employee Full Name";
                       MODIFY;
                   END
                   ELSE BEGIN
                       "Signatory 2 Position" := '';
                       "Signatory 2 Full Name" := '';
                       MODIFY;
                   END;*/
            end;
        }
        field(47; "Signatory 1 Position"; Text[250])
        {
            Caption = 'Signatory person 1 Position';
            Editable = false;
        }
        field(48; "Signatory 2 Position"; Text[250])
        {
            Caption = 'Signatory person 2 Position';
            Editable = false;
        }
        field(49; "Signatory 1 Full Name"; Text[150])
        {
            Caption = 'Signatory person 1 Full Name';
        }
        field(50; "Signatory 2 Full Name"; Text[150])
        {
            Caption = 'Signatory person 2 Full Name';
        }
        field(51; "Signatory 1 Contr With Benef"; Code[10])
        {
            Caption = 'Signatory 1 Contract With Benefits';
            // TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin
                /*    Position.SETFILTER("Employee No.", '%1', "Signatory 1 Contr With Benef");
                    IF Position.FIND('-') THEN BEGIN
                        "Signatory 1 With Benef Name" := Position."Employee Full Name";

                        MODIFY;
                    END
                    ELSE BEGIN
                        "Signatory 1 With Benef Name" := '';
                        MODIFY;
                    END;*/
            end;
        }
        field(52; "Signatory 1 With Benef Name"; Text[250])
        {
            Caption = 'Signatory 1 Contract With Benefits Full Name';
        }
        field(53; "Signatory 2 Contr With Benef"; Code[10])
        {
            Caption = 'Signatory 2 - Contract With Benefits';
            //   TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin
                /*  Position.SETFILTER("Employee No.", '%1', "Signatory 2 Contr With Benef");
                  IF Position.FIND('-') THEN BEGIN
                      "Signatory 2 With Benef Name" := Position."Employee Full Name";

                      MODIFY;
                  END
                  ELSE BEGIN
                      "Signatory 2 With Benef Name" := '';
                      MODIFY;
                  END;*/
            end;
        }
        field(54; "Signatory 2 With Benef Name"; Text[250])
        {
            Caption = 'Signatory 1 Contract With Benefits Full Name;';
        }
        field(55; "Changing Department"; Boolean)
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
                    END;
                    */

            end;
        }
        field(56; "Changing Group"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Group"."Changing Department" WHERE("Code" = FIELD("Code"),
                                                                    "Org Shema" = FIELD("ORG Shema")));
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
                    END;
                    */

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
        field(50005; "Sector Identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50006; "Department Idenity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50007; "Department Changing"; Boolean)
        {
            Caption = 'Department Changing';
        }
        field(50008; "Department Group identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50009; "Department Team identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50026; "Entity of Agency"; Option)
        {
            Caption = 'Entity of Agency';
            OptionCaption = ' ,FBIH,RS';
            OptionMembers = " ",FBIH,RS;
        }
    }

    keys
    {
        key(Key1; "Code", "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description)
        {
        }
        key(Key2; Description)
        {
        }
        key(Key3; "ORG Shema", "ORG Dio")
        {
        }
        key(Key4; "Team Description")
        {
        }
        key(Key5; "Department Categ.  Description")
        {
        }
        key(Key6; "Group Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Team Description", "Group Description", "Department Categ.  Description", "Sector  Description")
        {
        }
    }

    trigger OnDelete()
    begin

        OS.SETFILTER(Code, '%1', "ORG Shema");
        OS.SETFILTER(Status, '%1', OS.Status::Active);
        IF OS.FINDFIRST THEN BEGIN
            //ĐK      WPConnSetup.FINDFIRST();


            /*  CREATE(conn, TRUE, TRUE);

              conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                        +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

              CREATE(comm,TRUE, TRUE);

              lvarActiveConnection := conn;
              comm.ActiveConnection := lvarActiveConnection;

              comm.CommandText := 'dbo.Department_Delete';
              comm.CommandType := 4;
              comm.CommandTimeout := 0;

              param:=comm.CreateParameter('@Code', 200, 1, 30, Rec.Code);
              comm.Parameters.Append(param);

              comm.Execute;
              conn.Close;
              CLEAR(conn);
              CLEAR(comm);*/
        END;

        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15)
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);




        OS.SETFILTER(Code, '%1', "ORG Shema");
        OS.SETFILTER(Status, '%1', OS.Status::Active);
        IF OS.FINDFIRST THEN BEGIN
            //ĐK       WPConnSetup.FINDFIRST();


            /* CREATE(conn, TRUE, TRUE);

             conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                       +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));

             CREATE(comm,TRUE, TRUE);

             lvarActiveConnection := conn;
             comm.ActiveConnection := lvarActiveConnection;

             comm.CommandText := 'dbo.Department_Insert';
             comm.CommandType := 4;
             comm.CommandTimeout := 0;


             param:=comm.CreateParameter('@Code', 200, 1, 30, Code);
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@Description', 200, 1, 100, Description);
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@Type', 200, 1, 30, Type);
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@B_1', 200, 1, 30, Sector);
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('B_1_description', 200, 1, 250, "Sector  Description");
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@B_1_regions', 200, 1, 30, "Department Category");
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@B_1_regions_description', 200, 1, 250, "Department Categ.  Description");
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@stream', 200, 1, 30, "Group Code");
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@stream_description', 200, 1, 250, "Group Description");
             comm.Parameters.Append(param);

             param:=comm.CreateParameter('@Team', 200, 1, 30, "Team Code");
             comm.Parameters.Append(param);
             param:=comm.CreateParameter('@Team_description', 200, 1, 250, "Team Description");
             comm.Parameters.Append(param);

             comm.Execute;
             conn.Close;
             CLEAR(conn);
             CLEAR(comm);*/

        END;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        //ĐK  WPConnSetup: Record "Web portal connection setup";
        /* ĐK conn: Automation ;
        comm: Automation ;
        param: Automation ;*/
        lvarActiveConnection: Variant;
        "B-1Rec": Record "Sector";
        "B-1WithRegions": Record "Department Category";
        StreamRec: Record "Group";
        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";
        /* connAdm2: Automation ;
         commAdm2: Automation ;
         paramAdm2: Automation ;*/
        lvarActiveConnectionAdm2: Variant;
        // Position: Record "Confidential Clerks";
        // Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        TeamRec: Record "TeamT";
        LengthCode: Integer;
        // Tip: Record "Type";
        Dep: Record "Department";
        DC: Record "Department Category";
        TEAM: Record "TeamT";
        GR: Record "Group";
        SectorR: Record "Sector";
        NewDepartment: Record "Department";
        DepartmentCategory: Record "Department Category";
        SectorNew: Record "Sector";
        GroupNew: Record "Group";
        Team1: Record "TeamT";
        DepartmentCheck: Record "Department";
        DepartmentValidate: Record "Department";
        SectorT: Record "Sector";
        Zapis: Integer;
        DepartmentCategoryT: Record "Department Category";
        GroupT: Record "Group";
        TeamT: Record "TeamT";
        String: Text;
        Brojac: Integer;
        i: Integer;
        j: Integer;
        K: Integer;
        z: Integer;
}

