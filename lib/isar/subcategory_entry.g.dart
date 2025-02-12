// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubCategoryEntryCollection on Isar {
  IsarCollection<SubCategoryEntry> get subCategoryEntrys => this.collection();
}

const SubCategoryEntrySchema = CollectionSchema(
  name: r'SubCategoryEntry',
  id: 8560288892114763717,
  properties: {
    r'parentCategory': PropertySchema(
      id: 0,
      name: r'parentCategory',
      type: IsarType.string,
    ),
    r'subCategory': PropertySchema(
      id: 1,
      name: r'subCategory',
      type: IsarType.string,
    ),
    r'subCategoryColor': PropertySchema(
      id: 2,
      name: r'subCategoryColor',
      type: IsarType.long,
    )
  },
  estimateSize: _subCategoryEntryEstimateSize,
  serialize: _subCategoryEntrySerialize,
  deserialize: _subCategoryEntryDeserialize,
  deserializeProp: _subCategoryEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _subCategoryEntryGetId,
  getLinks: _subCategoryEntryGetLinks,
  attach: _subCategoryEntryAttach,
  version: '3.1.0+1',
);

int _subCategoryEntryEstimateSize(
  SubCategoryEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.parentCategory.length * 3;
  bytesCount += 3 + object.subCategory.length * 3;
  return bytesCount;
}

void _subCategoryEntrySerialize(
  SubCategoryEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.parentCategory);
  writer.writeString(offsets[1], object.subCategory);
  writer.writeLong(offsets[2], object.subCategoryColor);
}

SubCategoryEntry _subCategoryEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubCategoryEntry();
  object.id = id;
  object.parentCategory = reader.readString(offsets[0]);
  object.subCategory = reader.readString(offsets[1]);
  object.subCategoryColor = reader.readLong(offsets[2]);
  return object;
}

P _subCategoryEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _subCategoryEntryGetId(SubCategoryEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subCategoryEntryGetLinks(SubCategoryEntry object) {
  return [];
}

void _subCategoryEntryAttach(
    IsarCollection<dynamic> col, Id id, SubCategoryEntry object) {
  object.id = id;
}

extension SubCategoryEntryQueryWhereSort
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QWhere> {
  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SubCategoryEntryQueryWhere
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QWhereClause> {
  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SubCategoryEntryQueryFilter
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QFilterCondition> {
  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      parentCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryColorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subCategoryColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subCategoryColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subCategoryColor',
        value: value,
      ));
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterFilterCondition>
      subCategoryColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subCategoryColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SubCategoryEntryQueryObject
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QFilterCondition> {}

extension SubCategoryEntryQueryLinks
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QFilterCondition> {}

extension SubCategoryEntryQuerySortBy
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QSortBy> {
  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      sortByParentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategory', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      sortByParentCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategory', Sort.desc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      sortBySubCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategory', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      sortBySubCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategory', Sort.desc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      sortBySubCategoryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoryColor', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      sortBySubCategoryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoryColor', Sort.desc);
    });
  }
}

extension SubCategoryEntryQuerySortThenBy
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QSortThenBy> {
  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenByParentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategory', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenByParentCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategory', Sort.desc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenBySubCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategory', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenBySubCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategory', Sort.desc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenBySubCategoryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoryColor', Sort.asc);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QAfterSortBy>
      thenBySubCategoryColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subCategoryColor', Sort.desc);
    });
  }
}

extension SubCategoryEntryQueryWhereDistinct
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QDistinct> {
  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QDistinct>
      distinctByParentCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentCategory',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QDistinct>
      distinctBySubCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subCategory', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubCategoryEntry, SubCategoryEntry, QDistinct>
      distinctBySubCategoryColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subCategoryColor');
    });
  }
}

extension SubCategoryEntryQueryProperty
    on QueryBuilder<SubCategoryEntry, SubCategoryEntry, QQueryProperty> {
  QueryBuilder<SubCategoryEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SubCategoryEntry, String, QQueryOperations>
      parentCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentCategory');
    });
  }

  QueryBuilder<SubCategoryEntry, String, QQueryOperations>
      subCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subCategory');
    });
  }

  QueryBuilder<SubCategoryEntry, int, QQueryOperations>
      subCategoryColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subCategoryColor');
    });
  }
}
