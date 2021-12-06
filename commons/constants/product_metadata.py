"""
Add metadata field names(as in ES documents) in this file,
so it can be referenced in codebase.

e.g ANALYSIS_END_DATETIME_METADATA = "AnalysisEndDateTime"
"""
DAPHNE_MIN_TIME_TAG = "DAPHNE_Min_Time_Tag"
DAPHNE_MAX_TIME_TAG = "DAPHNE_Max_Time_Tag"

SCLKSCET = "SCLKSCET"
TYPE = "Type"

CREATION_DATE_TIME = "CreationDateTime"
FILE_CREATION_DATE_TIME = "FileCreationDateTime"
PRODUCT_RECEIVED_TIME = "ProductReceivedTime"
FILE_NAME = "FileName"
FIDELITY = "Fidelity"
GRANULE_NAME = "GranuleName"
PCM_RETRIEVAL_ID = "PCMRetrievalID"
COMPOSITE_RELEASE_ID = "CompositeReleaseID"
PRODUCT_COUNTER = "ProductCounter"
PRODUCT_TYPE = "ProductType"
DATATAKE_START_DATE_TIME = "DatatakeStartDateTime"
DATATAKE_STOP_DATE_TIME = "DatatakeStopDateTime"
RANGE_BEGINNING_DATE_TIME = "RangeBeginningDateTime"
RANGE_BEGINNING_YEAR = "RangeBeginningYear"
RANGE_BEGINNING_MONTH = "RangeBeginningMonth"
RANGE_BEGINNING_DAY = "RangeBeginningDay"
RANGE_ENDING_DATE_TIME = "RangeEndingDateTime"
RANGE_START_DATE_TIME = "RangeStartDateTime"
RANGE_STOP_DATE_TIME = "RangeStopDateTime"
VALIDITY_START_DATE_TIME = "ValidityStartDateTime"
VALIDITY_START_YEAR = "ValidityStartYear"
VALIDITY_START_MONTH = "ValidityStartMonth"
VALIDITY_START_DAY = "ValidityStartDay"
VALIDITY_END_DATE_TIME = "ValidityEndDateTime"
VALIDITY_DATE = "ValidityDate"
START_TIME_ISO = "start_time_iso"

# Catalog Metadata fields
PGE_NAME = "PGE_Name"
PGE_VERSION = "PGE_Version"
INPUT_FILES = "Input_Files"
ANCILLARY_FILES = "Ancillary_Files"
MIN_VCFC = "Min_VCFC"
MAX_VCFC = "Max_VCFC"
MISSING_VCFC_LIST = "Missing_VCFC_List"
MISSING_VCFC_ERT_LIST = "Missing_VCFC_ERT_List"
DAPHNE_FLAG_COUNT = "DAPHNE_Flag_Count"
PRODUCTION_DATE_TIME = "Production_DateTime"
RADAR_START_DATE_TIME = "RadarStartDateTime"
RADAR_STOP_DATE_TIME = "RadarStopDateTime"
GEO_LOCATION_START = "GeoLocationStart"
GEO_LOCATION_STOP = "GeoLocationStop"
S3_EVENT_RECORD = "S3_event_record"
SQS_RECORD = "SQS_record"
LAMBDA_TRIGGER_TIME = "Lambda_trigger_time"
SENT_TIMESTAMP = "SentTimestamp"
MODE = "Mode"
VCID = "VCID"
CYCLE_NUMBER = "CycleNumber"
RELATIVE_ORBIT_NUMBER = "RelativeOrbitNumber"
TRACK_FRAME = "TrackFrame"
TRACK_FRAME_POLYGON = "TrackFramePolygon"
BOUNDING_POLYGON = "Bounding_Polygon"
RADAR_MODE = "RadarMode"

# TODO: update these with what they will actually be
OBS_ID = "OBS_ID"
TOTAL_NUMBER_RANGELINES = "Total_Number_Rangelines"
TOTAL_NUMBER_OF_MISSING_RANGELINES = "Total_Number_Of_Missing_Rangelines"
TOTAL_NUMBER_OF_RANGELINES_FAILED_CHECKSUM = (
    "Total_Number_Of_Rangelines_Failed_Checksum"
)

# Product Types
NEN_L_RRST = "NEN_L_RRST"
L0B_L_RRSD = "L0B_L_RRSD"
LDF = "LDF"
LDF_STATE_CONFIG = "ldf-state-config"
DATATAKE_STATE_CONFIG = "datatake-state-config"
TRACK_FRAME_STATE_CONFIG = "track_frame-state-config"
NETWORK_PAIR_STATE_CONFIG = "network_pair-state-config"
STUF = "STUF"
L1_L_RSLC = "L1_L_RSLC"

# DAAC related metadata
DAAC_CATALOG_ID = "daac_catalog_id"
DAAC_CATALOG_URL = "daac_catalog_url"
DAAC_PRODUCT_FILE_URLS = "daac_product_file_urls"

# Metadata related to state-configs
START_TIME = "starttime"
END_TIME = "endtime"
LOCATION = "location"
STATE_CONFIG_CREATION_TIME = "creation_time"
LAST_MODIFIED_TIME = "last_modified_time"
EXPIRATION_TIME = "expiration_time"
IS_COMPLETE = "is_complete"
IS_URGENT = "is_urgent"
FORCE_SUBMIT = "force_submit"
SUBMITTED_BY_TIMER = "submitted_by_timer"

LDF_NAME = "ldf_name"
MISSING_RRSTS = "missing_rrsts"
FOUND_RRSTS = "found_rrsts"
RRST_PRODUCT_PATHS = "rrst_product_paths"
TRACK_FRAME_BEGIN_TIME = "track_frame_begin_time"
TRACK_FRAME_END_TIME = "track_frame_end_time"
PROCESSING_START_TIME = "processing_start_time"
PROCESSING_END_TIME = "processing_end_time"
TRACK_FRAME_DB_INFO = "track_frame_db_info"
OBSERVATION_IDS = "observation_ids"
OBSERVATION_ID = "observation_id"
DATATAKE_ID = "datatake_id"
DATATAKE_BEGIN_TIME = "datatake_begin_time"
DATATAKE_END_TIME = "datatake_end_time"
OBSERVATION_BEGIN_TIME = "observation_begin_time"
OBSERVATION_END_TIME = "observation_end_time"
FOUND_L0A_RRST = "found_l0a_rrsts"
FOUND_L0B_RRSDS = "found_l0b_rrsds"
L0A_RRST_PRODUCT_PATHS = "l0a_rrst_product_paths"
L0B_RRSD_PRODUCT_PATHS = "l0b_rrsd_product_paths"
DATA_SOURCE = "DataSource"
FRAME_COVERAGE = "FrameCoverage"
BEAM_NAME = "BeamName"
MISSION = "Mission"
SCID = "SCID"
STATION = "Station"
ANTENNA = "Antenna"
PASS = "Pass"
RECEIVER = "Receiver"
CHANNEL = "Channel"
GROUP = "Group"
PR = "PR"
COVERAGE_INDICATOR = "CoverageIndicator"
PROCESSING_TYPE = "ProcessingType"
DIRECTION = "Direction"
ID = "id"

REFERENCE_TRACK_FRAME_POLYGON = "ReferenceTrackFramePolygon"
SECONDARY_TRACK_FRAME_POLYGON = "SecondaryTrackFramePolygon"
NETWORK_PAIR_RSLCS = "network_pair_rslcs"
